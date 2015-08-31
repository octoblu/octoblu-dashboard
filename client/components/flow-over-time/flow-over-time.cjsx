React  = require 'react'
moment = require 'moment'
{Line} = require 'react-chartjs'

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

  componentDidMount: ->


  render: ->
    <div className= "flow-status__gauge">
      <Line data={@state.chartData} width="600" height="250"/>
    </div>

module.exports = FlowOverTime
