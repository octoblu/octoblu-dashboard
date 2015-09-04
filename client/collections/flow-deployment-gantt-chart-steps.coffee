Backbone = require 'backbone'
FlowDeploymentGanttChartStep = require '../models/flow-deployment-gantt-chart-step'

class FlowDeploymentGanttChartSteps extends Backbone.Collection
  model: FlowDeploymentGanttChartStep
  initialize: (models,options={}) =>
    @uuid = options.uuid

  url: =>
    "http://searchonly:q1c5j3slso793flgu0@0b0a9ec76284a09f16e189d7017ad116.us-east-1.aws.found.io:9200/flow_deploy_history/event/#{@uuid}"

  parse: (body) =>
    [
      _.extend workflow: 'app-octoblu', body._source['app-octoblu']
      _.extend workflow: 'api-octoblu', body._source['api-octoblu']
      _.extend workflow: 'flow-deploy-service', body._source['flow-deploy-service']
      _.extend workflow: 'flow-runner', body._source['flow-runner']
    ]

module.exports = FlowDeploymentGanttChartSteps
