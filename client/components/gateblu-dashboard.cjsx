React = require 'react'

GatebluAddDeviceStatus                 = require '../models/gateblu/gateblu-add-device-status'
GatebluAddDeviceSuccessOverTime        = require '../models/gateblu/gateblu-add-device-success-over-time'
GatebluAddDeviceAvgElapsedTime         = require '../models/gateblu/gateblu-add-device-avg-elapsed-time'
GatebluAddDeviceAvgElapsedTimeOverTime = require '../models/gateblu/gateblu-add-device-avg-elapsed-time-over-time'

OverTimeGauge       = require './over-time-gauge'
StatusGauge         = require './flow-status/status-gauge'
AvgElapsedTimeGauge = require './flow-status/avg-elapsed-time-gauge'

GatebluDashboard = React.createClass
  displayName: 'GatebluDashboard'

  getInitialState: ->
    total: 0
    successes: 0
    failures: 0
    successPercentage: 0
    avgElapsedTime: 0
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
      @setState gatebluAddDeviceSuccessOverTime: @gatebluAddDeviceSuccessOverTime.toJSON()

    @gatebluAddDeviceAvgElapsedTime = new GatebluAddDeviceAvgElapsedTime index: "gateblu_device_add"
    @gatebluAddDeviceAvgElapsedTime.on 'change', =>
      @setState @gatebluAddDeviceAvgElapsedTime.toJSON()

    @gatebluAddDeviceAvgElapsedTimeOverTime = new GatebluAddDeviceAvgElapsedTimeOverTime index: "gateblu_device_add"
    @gatebluAddDeviceAvgElapsedTimeOverTime.on 'change', =>
      @setState elapsedTimeChartData: @gatebluAddDeviceAvgElapsedTimeOverTime.toJSON()

  componentDidMount: ->
    @periodicallyFetchForModel @gatebluAddDeviceStatus
    @periodicallyFetchForModel @gatebluAddDeviceSuccessOverTime
    @periodicallyFetchForModel @gatebluAddDeviceAvgElapsedTime
    @periodicallyFetchForModel @gatebluAddDeviceAvgElapsedTimeOverTime

  periodicallyFetchForModel: (model) ->
    setInterval model.fetch, 60 * 1000
    model.fetch()

  render: ->
    <div className="dashboard">
      <StatusGauge
        title="Gateblu Add Device Success Rate"
        failures={@state.failures}
        successes={@state.successes}
        successPercentage={@state.successPercentage}
        total={@state.total} />

      <AvgElapsedTimeGauge
        title="Gateblu Add Device Average Time"
        avgElapsedTime={@state.avgElapsedTime} />

      <OverTimeGauge
        title="Gateblu Add Device Success Over Time"
        suffix="%"
        elapsedTimeChartData={@state.gatebluAddDeviceSuccessOverTime} />

      <OverTimeGauge
        title="Gateblu Add Device Average Time Over Time"
        suffix="%"
        elapsedTimeChartData={@state.elapsedTimeChartData} />
    </div>

module.exports = GatebluDashboard
