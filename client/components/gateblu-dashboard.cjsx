React = require('react')
GatebluAddDeviceStatus = require '../models/gateblu/gateblu-add-device-status'

StatusGauge = require './flow-status/status-gauge'

GatebluDashboard = React.createClass
  displayName: 'GatebluDashboard'

  getInitialState: ->
    total: 0
    successes: 0
    failures: 0
    successPercentage: 0

  componentWillMount: ->
    @gatebluAddDeviceStatus = new GatebluAddDeviceStatus index: "gateblu_device_add"
    @gatebluAddDeviceStatus.on 'change', =>
      @setState @gatebluAddDeviceStatus.toJSON()

  componentDidMount: ->
    setInterval @gatebluAddDeviceStatus.fetch, 60 * 1000
    @gatebluAddDeviceStatus.fetch()

  render: ->
    <div className="dashboard">
      <StatusGauge
        title="Gateblu Add Device Success Rate"
        failures={@state.failures}
        successes={@state.successes}
        successPercentage={@state.successPercentage}
        total={@state.total} />
    </div>

module.exports = GatebluDashboard
