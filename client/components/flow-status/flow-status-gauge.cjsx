React = require 'react'
moment = require 'moment'

FlowStatusGauge = React.createClass
  displayName: 'FlowStatusGauge'

  formatPercentage: (percentage) =>
    return "..." unless percentage?
    "#{percentage.toFixed 3}%"

  render: ->
    <div className="gauge">
      <h1>Flow Deploy Success Rate</h1>
      <h2>{@formatPercentage @props.successPercentage}</h2>
      <div className="raw-metrics">
        <p className="raw-metric">
          {@props.successes} <br /> successes
        </p>
        <p className="raw-metric">
          {@props.failures} <br /> failures
        </p>
        <p className="raw-metric">
          {@props.total} <br /> total
        </p>
      </div>
      <h5>Last 24 Hours</h5>
    </div>

module.exports = FlowStatusGauge
