Backbone = require 'backbone'
_ = require 'lodash'
moment = require 'moment'
FLOW_DEPLOY_AVG_ELAPSED_TIME_OVER_TIME_QUERY = require '../queries/flow-deploy-avg-elapsed-time-over-time.json'

class FlowDeployAvgElapsedTimeOverTime extends Backbone.Model
  url: "http://searchonly:q1c5j3slso793flgu0@0b0a9ec76284a09f16e189d7017ad116.us-east-1.aws.found.io:9200/flow_deploy_history/_search"

  parse: (response) =>
    console.log response.aggregations
    buckets = _.map response.aggregations.finished.startTime_over_time.buckets, (bucket) =>
      elapsedTime: bucket.avgElapsedTime.value
      key: bucket.key

    elapsedTimeByKey: buckets

  fetch: (options={}) =>
    super _.defaults({}, options,
      type: 'POST'
      data: JSON.stringify(@query())
      contentType: 'application/json'
    )

  query: =>
    yesterday = moment().subtract(1, 'day')
    query = _.cloneDeep FLOW_DEPLOY_AVG_ELAPSED_TIME_OVER_TIME_QUERY
    query.aggs.finished.filter.and[0].range._timestamp.gte = yesterday.valueOf()
    query

module.exports = FlowDeployAvgElapsedTimeOverTime
