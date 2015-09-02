React = require('react')
Router = require 'react-router'

GanttChart = require './flow-status/gantt-chart'

FlowDeployTrace = React.createClass
  displayName: 'FlowDeployTrace'
  mixins: [ Router.State ]

  getInitialState: ->
    {}

  componentWillMount: ->

  componentDidMount: ->

  render: ->
    <div className="dashboard">
      <GanttChart />
    </div>

module.exports = FlowDeployTrace
