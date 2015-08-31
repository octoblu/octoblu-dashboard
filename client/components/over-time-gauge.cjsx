React = require 'react'
moment = require 'moment'
{Line} = require 'react-chartjs'

OverTimeGauge = React.createClass
  displayName: 'OverTimeGauge'

  render: ->
    <div className= "gauge">
      <h1>{@props.title}</h1>
      <Line width="1600"
            height="900"
            data={@props.elapsedTimeChartData ? {datasets: []}}
            options={scaleFontSize: 30, scaleLabel: "<%=value%>#{@props.suffix}", scaleBeginAtZero: true, responsive: true}
            redraw />
    </div>

module.exports = OverTimeGauge
