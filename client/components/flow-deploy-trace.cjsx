React = require('react')
Router = require 'react-router'
_ = require 'lodash'

GanttChart = require './flow-status/gantt-chart'
FAKE_DATA = require './data/fake-deployment-data'

FlowDeployTrace = React.createClass
  displayName: 'FlowDeployTrace'
  mixins: [Router.State]

  getInitialState: ->
    {}

  componentWillMount: ->

  componentDidMount: ->

  render: ->
    <div className="dashboard">
      <GanttChart steps={FAKE_DATA}/>
    </div>

module.exports = FlowDeployTrace
