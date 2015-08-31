React = require 'react'
moment = require 'moment'
{Line} = require 'react-chartjs'

FlowAvgElapsedOverTimeGauge = React.createClass
  displayName: 'FlowAvgElapsedOverTimeGauge'

  render: ->
    <div className= "gauge">
      <h1>Flow Deploy Average Over Time</h1>
      <Line width="1600"
            height="900"
            data={@props.elapsedTimeChartData ? {datasets: []}}
            options={scaleFontSize: 40, scaleLabel: "<%=value%>s", scaleBeginAtZero: true}
            redraw />
      <h5>Last 24 Hours</h5>
    </div>

module.exports = FlowAvgElapsedOverTimeGauge
