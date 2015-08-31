React = require 'react'
moment = require 'moment'
{Line} = require 'react-chartjs'

FlowAvgElapsedOverTimeGauge = React.createClass
  displayName: 'FlowAvgElapsedOverTimeGauge'

  formatUnixTime: (unix_time) =>
    moment(unix_time).format 'HH:mm:ss ZZ (MM/DD)'

  render: ->
    <div className= "gauge">
      <h1>Flow Deploy Average Over Time</h1>
      <Line data={@props.elapsedTimeChartData} width="600" height="250" />
      <h3>{@formatUnixTime @props.timestamp}</h3>
    </div>

module.exports = FlowAvgElapsedOverTimeGauge
