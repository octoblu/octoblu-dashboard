Backbone = require 'backbone'
moment   = require 'moment'
_        = require 'lodash'

FlowDeploymentGanttChartStep = require '../models/flow-deployment-gantt-chart-step'

class FlowDeploymentGanttChartSteps extends Backbone.Collection
  model: FlowDeploymentGanttChartStep
  initialize: (models,options={}) =>
    @uuid = options.uuid

  url: =>
    "http://readonly:hfpxaq4e7k6gimwcwl@6afa8b1002a9aae2191763621313e6ea.us-west-1.aws.found.io:9200/flow_deploy_history/event/#{@uuid}"

  parse: (body) =>
    [
      _.extend workflow: 'app-octoblu', body._source['app-octoblu']
      _.extend workflow: 'api-octoblu', body._source['api-octoblu']
      _.extend workflow: 'flow-deploy-service', body._source['flow-deploy-service']
      _.extend workflow: 'flow-runner', body._source['flow-runner']
    ]

  totalTime: =>
    stepTimes = @map (model) => model.get('offset') + model.get('width')
    _.max stepTimes

module.exports = FlowDeploymentGanttChartSteps
