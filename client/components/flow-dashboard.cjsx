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
    flowDeployStatus: {}
    flowDeployOverTime:
      elapsedTimeChartData:
        labels: []
        datasets: []
    flowDeployAvgElapsedTime: {}
    flowDeployAvgElapsedTimeOverTime:
      elapsedTimeChartData:
        labels: []
        datasets: []

  componentWillReceiveProps: (nextProps) ->
    {inLast, byUnit} = nextProps.query

    @flowDeployStatus.set inLast: inLast, byUnit: byUnit
    @flowDeployStatus.fetch()
    @flowDeployOverTime.set inLast: inLast, byUnit: byUnit
    @flowDeployOverTime.fetch()
    @flowDeployAvgElapsedTime.set inLast: inLast, byUnit: byUnit
    @flowDeployAvgElapsedTime.fetch()
    @flowDeployAvgElapsedTimeOverTime.set inLast: inLast, byUnit: byUnit
    @flowDeployAvgElapsedTimeOverTime.fetch()

  componentWillMount: ->
    {inLast, byUnit} = @props.query
    @flowDeployStatus = new FlowDeployStatus index: 'flow_deploy', inLast: inLast, byUnit: byUnit
    @flowDeployStatus.on 'change', =>
      @setState flowDeployStatus: @flowDeployStatus.toJSON()

    @flowDeployOverTime = new FlowDeployOverTime index: 'flow_deploy', inLast: inLast, byUnit: byUnit
    @flowDeployOverTime.on 'change', =>
      @setState flowDeployOverTime: @flowDeployOverTime.toJSON()

    @flowDeployAvgElapsedTime = new FlowDeployAvgElapsedTime index: 'flow_deploy', inLast: inLast, byUnit: byUnit
    @flowDeployAvgElapsedTime.on 'change', =>
      @setState flowDeployAvgElapsedTime: @flowDeployAvgElapsedTime.toJSON()

    @flowDeployAvgElapsedTimeOverTime = new FlowDeployAvgElapsedTimeOverTime index: 'flow_deploy', inLast: inLast, byUnit: byUnit
    @flowDeployAvgElapsedTimeOverTime.on 'change', =>
      @setState flowDeployAvgElapsedTimeOverTime: @flowDeployAvgElapsedTimeOverTime.toJSON()

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
        failures={@state.flowDeployStatus.failures}
        successes={@state.flowDeployStatus.successes}
        successPercentage={@state.flowDeployStatus.successPercentage}
        total={@state.flowDeployStatus.total} />

      <AvgElapsedTimeGauge
        title="Flow Deploy Average Time"
        avgElapsedTime={@state.flowDeployAvgElapsedTime.avgElapsedTime} />

      <OverTimeGauge
        title="Flow Deploy Success Over Time"
        suffix="%"
        elapsedTimeChartData={@state.flowDeployOverTime.elapsedTimeChartData} />

      <OverTimeGauge
        title="Flow Deploy Average Over Time"
        suffix="s"
        elapsedTimeChartData={@state.flowDeployAvgElapsedTimeOverTime.elapsedTimeChartData} />
    </div>

module.exports = FlowDashboard
