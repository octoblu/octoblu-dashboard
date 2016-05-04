Backbone = require 'backbone'
moment   = require 'moment'

FlowDeploymentGanttChartStep = require '../models/flow-deployment-gantt-chart-step'
FLOW_DEPLOYMENT_AGGS_QUERY = require '../queries/flow-deployment-aggs-gantt-chart.json'

class FlowDeploymentGanttAggsChartSteps extends Backbone.Collection
  model: FlowDeploymentGanttChartStep

  url: =>
    "http://6afa8b1002a9aae2191763621313e6ea.us-west-1.aws.found.io:9200/flow_deploy_history/_search?search_type=count"

  parse: (body) =>
    aggs = body.aggregations.last_24_hours
    [
      {
        workflow: 'app-octoblu'
        beginOffset: aggs['app-octoblu-beginOffset'].value
        elapsedTime: aggs['app-octoblu-elapsedTime'].value
      }
      {
        workflow: 'api-octoblu'
        beginOffset: aggs['api-octoblu-beginOffset'].value
        elapsedTime: aggs['api-octoblu-elapsedTime'].value
      }
      {
        workflow: 'flow-deploy-service'
        beginOffset: aggs['flow-deploy-service-beginOffset'].value
        elapsedTime: aggs['flow-deploy-service-elapsedTime'].value
      }
      {
        workflow: 'flow-runner'
        beginOffset: aggs['flow-runner-beginOffset'].value
        elapsedTime: aggs['flow-runner-elapsedTime'].value
      }
    ]

  fetch: (options={}) =>
    super _.defaults({}, options,
      type: 'POST'
      data: JSON.stringify(@query())
      contentType: 'application/json'
    )

  query: =>
    yesterday = moment().subtract(24, 'hours')
    query = _.cloneDeep FLOW_DEPLOYMENT_AGGS_QUERY
    query.aggs.last_24_hours.filter.range.beginTime.gte = yesterday.unix()
    query

  totalTime: =>
    stepTimes = @map (model) => model.get('offset') + model.get('width')
    _.max stepTimes

module.exports = FlowDeploymentGanttAggsChartSteps
