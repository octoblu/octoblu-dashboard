React = require 'react'
moment = require 'moment'
PropTypes = React.PropTypes

AvgElapsedTimeGauge = React.createClass
  displayName: 'AvgElapsedTimeGauge'

  propTypes:
    title: PropTypes.string.isRequired,
    total: PropTypes.number.isRequired,
    failures: PropTypes.number.isRequired,
    successes: PropTypes.number.isRequired,
    successPercentage: PropTypes.number.isRequired,

  formatPercentage: (percentage) =>
    return "..." unless percentage?
    "#{percentage.toFixed 3}%"

  render: ->
    <div className="gauge">
      <h1>{@props.title}</h1>
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
    </div>

module.exports = AvgElapsedTimeGauge
