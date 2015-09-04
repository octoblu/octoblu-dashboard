React = require('react')
Router = require 'react-router'
_ = require 'lodash'

GanttChart = require './flow-status/gantt-chart'
FlowDeploymentSteps = require '../collections/flow-deployment-steps'

FlowDeployTrace = React.createClass
  displayName: 'FlowDeployTrace'
  mixins: [Router.State]

  getInitialState: ->
    {}

  componentWillMount: ->

  componentDidMount: ->
    @flowDeploymentSteps = new FlowDeploymentSteps [], uuid: @getParams().uuid
    @flowDeploymentSteps.on 'sync', =>
      @setState flowDeploymentSteps: @flowDeploymentSteps.toJSON()
    @flowDeploymentSteps.fetch()

  render: ->
    <div className="dashboard">
      <GanttChart steps={@state.flowDeploymentSteps}/>
    </div>

module.exports = FlowDeployTrace
