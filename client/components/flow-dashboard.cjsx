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
    @flowDeployStatus = new FlowDeployStatus index: "flow_deploy"
    @flowDeployStatus.on 'change', =>
      @setState @flowDeployStatus.toJSON()

    @flowDeployAvgElapsedTime = new FlowDeployAvgElapsedTime index: "flow_deploy"
    @flowDeployAvgElapsedTime.on 'change', =>
      @setState @flowDeployAvgElapsedTime.toJSON()

    @flowDeployAvgElapsedTimeOverTime = new FlowDeployAvgElapsedTimeOverTime index: "flow_deploy"
    @flowDeployAvgElapsedTimeOverTime.on 'change', =>
      @setState @flowDeployAvgElapsedTimeOverTime.toJSON()

    @flowDeployOverTime = new FlowDeployOverTime index: "flow_deploy"
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
        avgElapsedTime={@state.avgElapsedTime} />

      <OverTimeGauge
        title="Flow Deploy Success Over Time"
        suffix="%"
        elapsedTimeChartData={@state.flowDeployOverTime} />

      <OverTimeGauge
        title="Flow Deploy Average Over Time"
        suffix="s"
        elapsedTimeChartData={@state.elapsedTimeChartData} />
    </div>

module.exports = FlowDashboard
