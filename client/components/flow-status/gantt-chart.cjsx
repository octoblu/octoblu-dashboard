React = require 'react'
moment = require 'moment'

PropTypes = React.PropTypes
FAKE_DATA = require '../data/fake-deployment-data'

GanttChart = React.createClass
  displayName: 'GanttChart'

  propTypes:
    graphWidth: PropTypes.number
    graphHeight: PropTypes.number
    minWidth:   PropTypes.number
    colors:     PropTypes.array
    fontOffset: PropTypes.number

  getDefaultProps: ->
    graphWidth: 1600
    graphHeight: 500
    minWidth: 10
    fontOffset: 400
    colors: ['#fff', '#eee', '#ddd', '#ccc', '#bbb', '#aaa', '#999', '#888', '#777', '#666', '#555', '#444']

  drawStep: (step, i, minBeginTime, maxEndTime) ->
    scale = (@props.graphWidth - @props.minWidth - @props.fontOffset) / (maxEndTime - minBeginTime)
    color = @props.colors[i % @props.colors.length]

    beginTime = moment(step.beginTime).valueOf()
    endTime = moment(step.endTime).valueOf()

    duration = moment(step.endTime).diff(moment(step.beginTime), 'seconds', true)

    width  = (endTime - beginTime) * scale
    width  = @props.minWidth if width < @props.minWidth
    height = 100

    x = (beginTime - minBeginTime) * scale + @props.fontOffset
    y = i * (height + 10)

    label = "#{step.application} (#{duration}s)"

    <g key={i}>
      <rect x={x} y={y} width={width} height={height} fill={color} rx="5" ry="5" />
      <text x={0} y={y + 10 + (height/2) } fill={color}>{label}</text>
    </g>

  drawSteps: (steps) ->
    minBeginTime = @getMinBeginTime steps
    maxEndTime = @getMaxEndTime steps

    _.map steps, (step, i) =>
      @drawStep step, i, minBeginTime, maxEndTime

  getMinBeginTime: (steps) ->
    _.min _.map steps, (step) => moment(step.beginTime).valueOf()

  getMaxEndTime: (steps) ->
    _.max _.map steps, (step) => moment(step.endTime).valueOf()

  getViewBox: ->
    [0, 0, @props.graphWidth, @props.graphHeight].join ' '

  render: ->
    <svg className="gantt-chart" xmlns="http://www.w3.org/svg/2000"
      viewBox={@getViewBox()} >
      {@drawSteps FAKE_DATA}
    </svg>

module.exports = GanttChart
