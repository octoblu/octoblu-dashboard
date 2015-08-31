React = require('react')
FlowDeployStatus = require '../models/flow-deploy-status'
FlowStatusGauge = require './flow-status/flow-status-gauge'

DashboardController = React.createClass
  displayName: 'DashboardController'

  getInitialState: ->
    {}

  componentWillMount: ->
    @flowDeployStatus = new FlowDeployStatus
    @flowDeployStatus.on 'change', =>
      @setState @flowDeployStatus.toJSON()

  componentDidMount: ->
    @flowDeployStatus.fetch()

  render: ->
    <FlowStatusGauge
      failures={@state.failures}
      successes={@state.successes}
      successPercentage={@state.successPercentage}
      total={@state.total}
      timestamp={@state._timestamp} />

module.exports = DashboardController
