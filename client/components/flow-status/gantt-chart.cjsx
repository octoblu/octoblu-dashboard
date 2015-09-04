React = require 'react'
moment = require 'moment'

PropTypes = React.PropTypes

GanttChart = React.createClass
  displayName: 'GanttChart'

  propTypes:
    colors:       PropTypes.array
    graphHeight:  PropTypes.number
    graphWidth:   PropTypes.number
    labelWidth:  PropTypes.number
    minStepWidth: PropTypes.number
    stepHeight:   PropTypes.number
    steps:        PropTypes.array
    title:        PropTypes.string
    titleColor:   PropTypes.string
    titleHeight:  PropTypes.number

  getDefaultProps: ->
    colors: ['#fff', '#eee', '#ddd', '#ccc', '#bbb', '#aaa', '#999', '#888', '#777', '#666', '#555', '#444']
    graphHeight: 500
    graphWidth: 1600
    labelWidth: 400
    minStepWidth: 10
    stepHeight: 100
    steps: []
    title: 'Gantt Chart'
    titleColor: '#fff'
    titleHeight: 100

  drawStep: (step, i, scale) ->
    color = @props.colors[i % @props.colors.length]

    height = @props.stepHeight

    width  = step.width * scale
    width  = @props.minStepWidth if width < @props.minStepWidth
    width = 0 unless step.offset? && step.width?

    x = @props.labelWidth + (step.offset * scale)
    y = (i * (height + 10)) + @props.titleHeight

    label = step.label

    <g key={i}>
      <rect x={x} y={y} width={width} height={height} fill={color} rx="5" ry="5" />
      <text x={0} y={y + 10 + (height/2) } fill={color}>{label}</text>
    </g>

  drawSteps: ->
    steps = @props.steps
    width = @getWidth steps
    scale = (@props.graphWidth - @props.labelWidth) / (width + @props.minStepWidth)

    _.map steps, (step, i) =>
      @drawStep step, i, scale

  drawTitle: ->
    <text className="title"
          x={@props.graphWidth / 2}
          y={@props.titleHeight / 2}
          width={@props.graphWidth}
          fill={@props.titleColor}
          >{@props.title}</text>

  getWidth: (steps) ->
    stepSize = _.map steps, (step) =>
      return step.offset + step.width

    _.max stepSize

  getViewBox: ->
    [0, 0, @props.graphWidth, @props.graphHeight].join ' '

  render: ->
    <svg className="gantt-chart" xmlns="http://www.w3.org/svg/2000"
      viewBox={@getViewBox()} >
      {@drawTitle()}
      {@drawSteps()}
    </svg>

module.exports = GanttChart
