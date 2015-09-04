React = require('react')
Router = require 'react-router'
_ = require 'lodash'

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

  render: ->
    <div className="dashboard">
      <GanttChart steps={@state.flowDeploymentAggsGanttChartSteps}/>
    </div>

module.exports = FlowDeploymentAggs
