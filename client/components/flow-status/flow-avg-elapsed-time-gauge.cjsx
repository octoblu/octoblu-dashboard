React = require 'react'
moment = require 'moment'

FlowAvgElapsedTimeGauge = React.createClass
  displayName: 'FlowStatusGauge'

  formatUnixTime: (unix_time) =>
    moment(unix_time).format 'HH:mm:ss ZZ (MM/DD)'

  render: ->
    <div className= "flow-status-gauge">
      <h1>Flow Deploy Average Time</h1>
      <h2>{Math.round(@props.avgElapsedTime/1000, 1)}s</h2>
      <h3>{@formatUnixTime @props.timestamp}</h3>
    </div>

module.exports = FlowAvgElapsedTimeGauge
