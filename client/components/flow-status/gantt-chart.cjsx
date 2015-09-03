React = require 'react'
moment = require 'moment'

PropTypes = React.PropTypes

GanttChart = React.createClass
  displayName: 'GanttChart'

  propTypes:
    graphWidth:  PropTypes.number
    graphHeight: PropTypes.number
    stepHeight:  PropTypes.number
    minStepWidth:    PropTypes.number
    colors:      PropTypes.array
    labelOffset: PropTypes.number
    steps:       PropTypes.array

  getDefaultProps: ->
    graphWidth: 1600
    graphHeight: 500
    stepHeight: 100
    minStepWidth: 10
    labelOffset: 400
    colors: ['#fff', '#eee', '#ddd', '#ccc', '#bbb', '#aaa', '#999', '#888', '#777', '#666', '#555', '#444']
    steps: []

  drawStep: (step, i, scale) ->
    color = @props.colors[i % @props.colors.length]

    height = @props.stepHeight

    width  = step.width * scale
    width  = @props.minStepWidth if width < @props.minStepWidth
    width = 0 unless step.offset? && step.width?

    x = @props.labelOffset + (step.offset * scale)
    y = i * (height + 10)

    label = step.label

    <g key={i}>
      <rect x={x} y={y} width={width} height={height} fill={color} rx="5" ry="5" />
      <text x={0} y={y + 10 + (height/2) } fill={color}>{label}</text>
    </g>

  drawSteps: ->
    steps = @props.steps
    width = @getWidth steps
    scale = (@props.graphWidth - @props.labelOffset) / (width + @props.minStepWidth)

    _.map steps, (step, i) =>
      @drawStep step, i, scale

  getWidth: (steps) ->
    stepSize = _.map steps, (step) =>
      return step.offset + step.width

    _.max stepSize

  getViewBox: ->
    [0, 0, @props.graphWidth, @props.graphHeight].join ' '

  render: ->
    <svg className="gantt-chart" xmlns="http://www.w3.org/svg/2000"
      viewBox={@getViewBox()} >
      {@drawSteps()}
    </svg>

module.exports = GanttChart
