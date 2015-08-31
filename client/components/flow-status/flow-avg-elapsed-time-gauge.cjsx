React = require 'react'
moment = require 'moment'

FlowAvgElapsedTimeGauge = React.createClass
  displayName: 'FlowAvgElapsedTimeGauge'

  formatUnixTime: (unix_time) =>
    moment(unix_time).format 'HH:mm:ss ZZ (MM/DD)'

  render: ->
    <div className= "gauge">
      <h1>Flow Deploy Average Time</h1>
      <h2>{Math.round(@props.avgElapsedTime/1000, 1)}s</h2>
      <h3>{@formatUnixTime @props.timestamp}</h3>
    </div>

module.exports = FlowAvgElapsedTimeGauge
