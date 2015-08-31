React = require('react')
FlowDeployStatus = require '../models/flow-deploy-status'
FlowDeployAvgElapsedTime = require '../models/flow-deploy-avg-elapsed-time'
FlowStatusGauge = require './flow-status/flow-status-gauge'
FlowAvgElapsedTimeGauge = require './flow-status/flow-avg-elapsed-time-gauge'

DashboardController = React.createClass
  displayName: 'DashboardController'

  getInitialState: ->
    {}

  componentWillMount: ->
    @flowDeployStatus = new FlowDeployStatus
    @flowDeployStatus.on 'change', =>
      @setState @flowDeployStatus.toJSON()

    @flowDeployAvgElapsedTime = new FlowDeployAvgElapsedTime
    @flowDeployAvgElapsedTime.on 'change', =>
      @setState @flowDeployAvgElapsedTime.toJSON()

  componentDidMount: ->
    setInterval @flowDeployStatus.fetch, 60 * 1000
    @flowDeployStatus.fetch()
    setInterval @flowDeployAvgElapsedTime.fetch, 60 * 1000
    @flowDeployAvgElapsedTime.fetch()

  render: ->
    <div>
    <FlowStatusGauge
      failures={@state.failures}
      successes={@state.successes}
      successPercentage={@state.successPercentage}
      total={@state.total} />

    <FlowAvgElapsedTimeGauge
      avgElapsedTime={@state.avgElapsedTime}
      timestamp={@state._timestamp} />
    </div>

module.exports = DashboardController
