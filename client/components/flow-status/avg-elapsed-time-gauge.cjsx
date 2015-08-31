React = require 'react'
moment = require 'moment'

AvgElapsedTimeGauge = React.createClass
  displayName: 'AvgElapsedTimeGauge'

  render: ->
    <div className= "gauge">
      <h1>{@props.title}</h1>
      <h2>{Math.round(@props.avgElapsedTime/1000, 1)}s</h2>
    </div>

module.exports = AvgElapsedTimeGauge
