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
    @flowDeploymentSteps = new FlowDeploymentGanttChartSteps [], uuid: @getParams().uuid
    @flowDeploymentSteps.on 'sync', =>
      @setState flowDeploymentSteps: @flowDeploymentSteps.toJSON()
    @flowDeploymentSteps.fetch()

  render: ->
    <div className="dashboard">
      <GanttChart steps={@state.flowDeploymentSteps}/>
    </div>

module.exports = FlowDeployment
