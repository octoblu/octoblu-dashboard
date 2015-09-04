React = require('react')
Router = require 'react-router'
_ = require 'lodash'

GanttChart = require './flow-status/gantt-chart'
FlowDeploymentGanttChartSteps = require '../collections/flow-deployment-gantt-chart-steps'

FlowDeployment = React.createClass
  displayName: 'FlowDeployment'
  mixins: [Router.State]

  getInitialState: ->
    {}

  componentWillMount: ->

  componentDidMount: ->
    @flowDeploymentGanttChartSteps = new FlowDeploymentGanttChartSteps [], uuid: @getParams().uuid
    @flowDeploymentGanttChartSteps.on 'sync', =>
      @setState flowDeploymentGanttChartSteps: @flowDeploymentGanttChartSteps.toJSON()
    @flowDeploymentGanttChartSteps.fetch()

  getTitle: ->
    uuid       = @getParams().uuid
    totalTimeMilliseconds  = @flowDeploymentGanttChartSteps?.totalTime()
    return 'loading...' unless totalTimeMilliseconds?
    totalTime = (totalTimeMilliseconds / 1000).toFixed 2

    "#{uuid} (#{totalTime}s)"

  render: ->
    <div className="dashboard">
      <GanttChart steps={@state.flowDeploymentGanttChartSteps} title={@getTitle()}/>
    </div>

module.exports = FlowDeployment
