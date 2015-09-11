React = require 'react'
_     = require 'lodash'

LoadingIndicator = require './loading-indicator'
Percentagify = require './percentagify'

DeviceInstallsTable = React.createClass
  displayName: 'DeviceInstallsTable'

  propTypes:
    devices: React.PropTypes.array.isRequired
    isFetching: React.PropTypes.bool.isRequired

  renderTableRowItem: (device, index) ->
    <tr key={index}>
      <td className="tabel-row table-row--name" colSpan="10">{device.name}</td>
      <td className="table-row" colSpan="5"><Percentagify value={device.successPercentage}/></td>
      <td className="table-row" colSpan="2">{device.successes}</td>
      <td className="table-row" colSpan="2">{device.failures}</td>
    </tr>

  render: ->
    return <LoadingIndicator /> if @props.isFetching
    <table className="device-install-table">
      <thead>
        <tr>
          <th className="table-header" colSpan="10">Device Name</th>
          <th className="table-header" colSpan="5">Success Rate</th>
          <th className="table-header" colSpan="2">Successes</th>
          <th className="table-header" colSpan="2">Failures</th>
        </tr>
      </thead>
      <tbody>
        {_.map @props.devices, @renderTableRowItem}
      </tbody>
    </table>

module.exports = DeviceInstallsTable
