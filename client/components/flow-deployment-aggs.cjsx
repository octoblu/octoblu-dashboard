React = require('react')
Router = require 'react-router'
_ = require 'lodash'
moment = require 'moment'

GanttChart = require './flow-status/gantt-chart'
FlowDeploymentAggsGanttChartSteps = require '../collections/flow-deployment-aggs-gantt-chart-steps'

FlowDeploymentAggs = React.createClass
  displayName: 'FlowDeploymentAggs'
  mixins: [Router.State]

  getInitialState: ->
    {}

  componentWillMount: ->

  componentDidMount: ->
    @flowDeploymentAggsGanttChartSteps = new FlowDeploymentAggsGanttChartSteps [], uuid: @getParams().uuid
    @flowDeploymentAggsGanttChartSteps.on 'sync', =>
      @setState flowDeploymentAggsGanttChartSteps: @flowDeploymentAggsGanttChartSteps.toJSON()
    @flowDeploymentAggsGanttChartSteps.fetch()

  getTitle: ->
    totalTimeMilliseconds  = @flowDeploymentAggsGanttChartSteps?.totalTime()
    return 'loading...' unless totalTimeMilliseconds?
    totalTime = (totalTimeMilliseconds / 1000).toFixed 2

    "Last 24 hours (#{totalTime}s)"

  render: ->
    <div className="dashboard">
      <GanttChart steps={@state.flowDeploymentAggsGanttChartSteps} title={@getTitle()}/>
    </div>

module.exports = FlowDeploymentAggs
