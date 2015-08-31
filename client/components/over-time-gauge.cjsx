React = require 'react'
moment = require 'moment'
{Line} = require 'react-chartjs'

OverTimeGauge = React.createClass
  displayName: 'OverTimeGauge'

  formatUnixTime: (unix_time) =>
    moment(unix_time).format 'HH:mm:ss ZZ (MM/DD)'

  render: ->
    <div className= "gauge">
      <h1>{@props.title}</h1>
      <Line width="1600"
            height="900"
            data={@props.elapsedTimeChartData ? {datasets: []}}
            options={scaleFontSize: 40, scaleLabel: "<%=value%>#{@props.suffix}", scaleBeginAtZero: true}
            redraw />
      <h3>{@formatUnixTime @props.timestamp}</h3>
    </div>

module.exports = OverTimeGauge
