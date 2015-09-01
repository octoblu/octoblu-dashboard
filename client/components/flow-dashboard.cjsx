React = require('react')
FlowDeployStatus = require '../models/flow-deploy-status'
FlowDeployAvgElapsedTime = require '../models/flow-deploy-avg-elapsed-time'
FlowDeployAvgElapsedTimeOverTime = require '../models/flow-deploy-avg-elapsed-time-over-time'
FlowDeployOverTime = require '../models/flow-deploy-over-time'

StatusGauge = require './flow-status/status-gauge'
AvgElapsedTimeGauge = require './flow-status/avg-elapsed-time-gauge'
OverTimeGauge = require './over-time-gauge'

FlowDashboard = React.createClass
  displayName: 'FlowDashboard'

  getInitialState: ->
    {}

  componentWillMount: ->
    @flowDeployStatus = new FlowDeployStatus
    @flowDeployStatus.on 'change', =>
      @setState @flowDeployStatus.toJSON()

    @flowDeployAvgElapsedTime = new FlowDeployAvgElapsedTime
    @flowDeployAvgElapsedTime.on 'change', =>
      @setState @flowDeployAvgElapsedTime.toJSON()

    @flowDeployAvgElapsedTimeOverTime = new FlowDeployAvgElapsedTimeOverTime
    @flowDeployAvgElapsedTimeOverTime.on 'change', =>
      @setState @flowDeployAvgElapsedTimeOverTime.toJSON()

    @flowDeployOverTime = new FlowDeployOverTime
    @flowDeployOverTime.on 'change', =>
      @setState flowDeployOverTime: @flowDeployOverTime.toJSON()

  componentDidMount: ->
    setInterval @flowDeployStatus.fetch, 60 * 1000
    @flowDeployStatus.fetch()
    setInterval @flowDeployAvgElapsedTime.fetch, 60 * 1000
    @flowDeployAvgElapsedTime.fetch()
    setInterval @flowDeployAvgElapsedTimeOverTime.fetch, 60 * 1000
    @flowDeployAvgElapsedTimeOverTime.fetch()
    setInterval @flowDeployOverTime.fetch, 60 * 1000
    @flowDeployOverTime.fetch()

  render: ->
    <div className="dashboard">
      <StatusGauge
        title="Flow Deploy Success Rate"
        failures={@state.failures}
        successes={@state.successes}
        successPercentage={@state.successPercentage}
        total={@state.total} />

      <AvgElapsedTimeGauge
        title="Flow Deploy Average Time"
        avgElapsedTime={@state.avgElapsedTime}
        timestamp={@state._timestamp} />

      <OverTimeGauge
        title="Flow Deploy Average Over Time"
        suffix="s"
        elapsedTimeChartData={@state.elapsedTimeChartData}
        timestamp={@state._timestamp} />

      <OverTimeGauge
        title="Flow Deploy Success Over Time"
        suffix="%"
        elapsedTimeChartData={@state.flowDeployOverTime}
        timestamp={@state._timestamp} />

    </div>

module.exports = FlowDashboard
