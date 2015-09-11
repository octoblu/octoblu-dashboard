React = require 'react'

Percentagify = React.createClass
  displayName: 'Percentagify'

  propTypes:
    value: React.PropTypes.number.isRequired

  formatPercentage: (value) =>
    return "#{value}%" if Math.round(value) == value
    return "..." unless value?
    "#{value.toFixed 2}%"

  render: ->
    <span>{ @formatPercentage @props.value }</span>

module.exports = Percentagify
