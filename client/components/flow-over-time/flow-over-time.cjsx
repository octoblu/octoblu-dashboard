React  = require 'react'
moment = require 'moment'
{Line} = require 'react-chartjs'
FlowDeployOverTime = require '../../models/flow-deploy-over-time'

FlowOverTime = React.createClass
  displayName: 'FlowOverTime'

  getInitialState: ->
    return {
      chartData:
        labels: ["2015-08-31T17:35:19+00:00", "2015-08-31T17:35:19+00:00", "2015-08-31T17:50:14+00:00"]
        datasets: [
          {
            data: [60, 50, 52]
          }
        ]
    }

  componentWillMount: ->
    @flowDeployOverTime = new FlowDeployOverTime
    @flowDeployOverTime.on 'change', =>
      @setState @formatResult @flowDeployOverTime.toJSON()

  componentDidMount: ->
    setInterval @flowDeployOverTime.fetch, 60 * 1000
    @flowDeployOverTime.fetch()

  formatResult: (results) =>
    chartData = {}
    chartData.labels = _.pluck results, 'key'
    points = []
    _.each results, (result) =>
      points.push result.successPercentage
    chartData.datasets = [data: points]
    console.log chartData
    return chartData: chartData

  render: ->
    <div className= "flow-status__gauge">
      <Line data={@state.chartData} width="600" height="250"/>
    </div>

module.exports = FlowOverTime
