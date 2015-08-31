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
      <Line width="1600"
            height="900"
            data={@props.elapsedTimeChartData ? {datasets: []}}
            options={scaleFontSize: 40, scaleLabel: "<%=value%>s", scaleBeginAtZero: true}
            redraw />
      <h3>{@formatUnixTime @props.timestamp}</h3>
    </div>

module.exports = FlowAvgElapsedOverTimeGauge
