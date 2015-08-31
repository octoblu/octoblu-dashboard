React = require 'react'
moment = require 'moment'

FlowAvgElapsedOverTimeGauge = React.createClass
  displayName: 'FlowStatusGauge'

  formatUnixTime: (unix_time) =>
    moment(unix_time).format 'HH:mm:ss ZZ (MM/DD)'

  renderDatapoints: (buckets) =>
    console.log buckets
    _.map buckets, (bucket) =>
      console.log bucket
      <h2>{moment(bucket.key).format('MM/DD HH:00')} - {Math.round(bucket.elapsedTime/1000)}</h2>

  render: ->
    <div className= "gauge">
      <h1>Flow Deploy Average Over Time</h1>
      {@renderDatapoints(@props.elapsedTimeByKey)}
      <h3>{@formatUnixTime @props.timestamp}</h3>
    </div>

module.exports = FlowAvgElapsedOverTimeGauge
