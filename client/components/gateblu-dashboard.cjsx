React = require('react')
GatebluAddDeviceStatus = require '../models/gateblu/gateblu-add-device-status'
GatebluAddDeviceSuccessOverTime = require '../models/gateblu/gateblu-add-device-success-over-time'

StatusGauge = require './flow-status/status-gauge'
OverTimeGauge = require './over-time-gauge'

GatebluDashboard = React.createClass
  displayName: 'GatebluDashboard'

  getInitialState: ->
    total: 0
    successes: 0
    failures: 0
    successPercentage: 0
    gatebluAddDeviceSuccessOverTime:
      index: 'gateblu_device_add'
      datasets: []
      labels: []

  componentWillMount: ->
    @gatebluAddDeviceStatus = new GatebluAddDeviceStatus index: "gateblu_device_add"
    @gatebluAddDeviceStatus.on 'change', =>
      @setState @gatebluAddDeviceStatus.toJSON()

    @gatebluAddDeviceSuccessOverTime = new GatebluAddDeviceSuccessOverTime index: "gateblu_device_add"
    @gatebluAddDeviceSuccessOverTime.on 'change', =>
      console.log 'gatebluAddDeviceSuccessOverTime', @gatebluAddDeviceSuccessOverTime.toJSON()
      @setState gatebluAddDeviceSuccessOverTime: @gatebluAddDeviceSuccessOverTime.toJSON()

  componentDidMount: ->
    setInterval @gatebluAddDeviceStatus.fetch, 60 * 1000
    @gatebluAddDeviceStatus.fetch()

    setInterval @gatebluAddDeviceSuccessOverTime.fetch, 60 * 1000
    @gatebluAddDeviceSuccessOverTime.fetch()

  render: ->
    <div className="dashboard">
      <StatusGauge
        title="Gateblu Add Device Success Rate"
        failures={@state.failures}
        successes={@state.successes}
        successPercentage={@state.successPercentage}
        total={@state.total} />

      <OverTimeGauge
        title="Gateblu Add Device Success Over Time"
        suffix="%"
        elapsedTimeChartData={@state.gatebluAddDeviceSuccessOverTime} />

    </div>

module.exports = GatebluDashboard
