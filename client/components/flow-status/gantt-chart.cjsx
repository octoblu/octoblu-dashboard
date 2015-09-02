React = require 'react'
FAKE_DATA = require '../data/fake-deployment-data'
COLORS = ['#f00', '#0f0', '#00f', '#ff0', '#f0f', '#0ff']

GanttChart = React.createClass
  displayName: 'GanttChart'

  propTypes: {}

  drawStep: (step, i) ->
    color = COLORS[i % COLORS.length]
    x = 110 * i

    <rect x={x} y="0" width="100" height="100" fill={color} />

  drawSteps: (steps) ->
    _.map steps, @drawStep

  render: ->
    <svg xmlns="http://www.w3.org/svg/2000"
      viewBox="0 0 1600 900"
      width="1600"
      height="900" >
      {@drawSteps FAKE_DATA}
    </svg>

module.exports = GanttChart
