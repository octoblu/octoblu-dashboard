React  = require 'react'
moment = require 'moment'
{Line} = require 'react-chartjs'
FlowDeployOverTime = require '../../models/flow-deploy-over-time'
class FlowOverTime extends React.Component
  displayName: 'FlowOverTime'

  constructor: ->
    @state =
      chartData:
        labels: ["2015-08-31T17:35:19+00:00", "2015-08-31T17:35:19+00:00", "2015-08-31T17:50:14+00:00"]
        datasets: [ data: [60, 50, 52] ]

  componentWillMount: =>
    @flowDeployOverTime = new FlowDeployOverTime
    @flowDeployOverTime.on 'change', =>
      @setState @formatResult @flowDeployOverTime.toJSON()

  componentDidMount: =>
    setInterval @flowDeployOverTime.fetch, 60 * 1000
    @flowDeployOverTime.fetch()

  formatResult: (results) =>
    chartData = {}
    chartData.labels = _.pluck results, 'key'
    points = []
    _.each results, (result) =>
      points.push result.successPercentage
    chartData.datasets = [data: points]

    return chartData: chartData

  render: =>
    <div className= "flow-status__gauge">
      <h2>Great Chart of Flow Deploy Over Time</h2>
      <Line data={@state.chartData} redraw width="1000" height="1000"/>
    </div>

module.exports = FlowOverTime
