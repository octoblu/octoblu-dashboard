Backbone = require 'backbone'
_ = require 'lodash'
moment = require 'moment'
FLOW_DEPLOY_AVG_ELAPSED_TIME_QUERY = require '../queries/flow-deploy-avg-elapsed-time.json'

class FlowDeployAvgElapsedTime extends Backbone.Model
  url: "http://searchonly:q1c5j3slso793flgu0@0b0a9ec76284a09f16e189d7017ad116.us-east-1.aws.found.io:9200/flow_deploy_history/_search"

  parse: (response) =>
    avgElapsedTime: response.aggregations.finished.avgElapsedTime.value

  fetch: (options={}) =>
    super _.defaults({}, options,
      type: 'POST'
      data: JSON.stringify(@query())
      contentType: 'application/json'
    )

  query: =>
    yesterday = moment().subtract(1, 'day')
    query = _.cloneDeep FLOW_DEPLOY_AVG_ELAPSED_TIME_QUERY
    query.aggs.finished.filter.and[0].range._timestamp.gte = yesterday.valueOf()
    query

module.exports = FlowDeployAvgElapsedTime
