React = require 'react'
moment = require 'moment'

FlowStatusGauge = React.createClass
  displayName: 'FlowStatusGauge'

  formatUnixTime: (unix_time) =>
    moment(unix_time).format 'HH:mm:ss ZZ (MM/DD)'

  render: ->
    <div className= "flow-status__gauge">
      <h1>Flow Deploy Success Rate</h1>
      <h2>{@props.successPercentage}%</h2>
      <h3>{@formatUnixTime @props.timestamp}</h3>
    </div>

module.exports = FlowStatusGauge
