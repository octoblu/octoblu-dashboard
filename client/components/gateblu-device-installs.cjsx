React = require 'react'
_     = require 'lodash'

DeviceInstallsTable = require './device-installs-table'
GatebluDeviceInstalls = require '../models/gateblu/gateblu-device-installs'

GatebluDeviceInstallsDashboard = React.createClass
  displayName: 'GatebluDeviceInstallsDashboard'

  getInitialState: ->
    isFetching: true
    devices: []

  componentWillMount: ->
    @gatebluDeviceInstalls = new GatebluDeviceInstalls index: "gateblu_device_detail"
    @gatebluDeviceInstalls.on 'change', =>
      @setState
        isFetching: false
        devices: _.sortBy @gatebluDeviceInstalls.toJSON().devices, 'successPercentage'


  componentDidMount: ->
    @periodicallyFetchForModel @gatebluDeviceInstalls

  periodicallyFetchForModel: (model) ->
    setInterval model.fetch, 60 * 1000
    model.fetch()

  render: ->
    <div className="dashboard">
      <DeviceInstallsTable devices={@state.devices} isFetching={@state.isFetching}/>
    </div>

module.exports = GatebluDeviceInstallsDashboard
