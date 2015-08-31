React = require 'react'
moment = require 'moment'

FlowAvgElapsedTimeGauge = React.createClass
  displayName: 'FlowAvgElapsedTimeGauge'

  render: ->
    <div className= "gauge">
      <h1>Flow Deploy Average Time</h1>
      <h2>{Math.round(@props.avgElapsedTime/1000, 1)}s</h2>
      <h5>Last 24 Hours</h5>
    </div>

module.exports = FlowAvgElapsedTimeGauge
