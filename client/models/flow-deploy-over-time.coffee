Backbone = require 'backbone'
_ = require 'lodash'
moment = require 'moment'
FLOW_DEPLOY_SUCCESS_OVER_TIME = require '../queries/flow-deploy-success-over-time.json'

class FlowDeployOverTime extends Backbone.Model
  url: "http://searchonly:q1c5j3slso793flgu0@0b0a9ec76284a09f16e189d7017ad116.us-east-1.aws.found.io:9200/flow_deploy_history/_search?search_type=count"

  parse: (response) =>
    buckets = response.aggregations.group_by_date.buckets
    result = _.map buckets, @parseBucket
    console.log result
    return result

  parseBucket: (bucket) =>
    successBuckets = _.filter bucket.group_by_success.buckets, key: 'T'
    failureBuckets = _.filter bucket.group_by_success.buckets, key: 'F'
    addCount = (count, bucket) =>
      return count += bucket.doc_count
    successCount = _.reduce successBuckets, addCount, 0
    failureCount = _.reduce failureBuckets, addCount, 0
    data =
      key: bucket.key
      successPercentage: (successCount / (successCount + failureCount)) * 100
      failureCount: _.findWhere bucket.group_by_success.buckets, key: 'F'
    return data

  fetch: (options={}) =>
    defaults =
      type: 'POST'
      data: JSON.stringify @query()
      contentType: 'application/json'
    super _.defaults {}, options, defaults

  query: =>
    query = _.cloneDeep FLOW_DEPLOY_SUCCESS_OVER_TIME
    ranges = []
    ranges.push to: "now", from: "now-1h/h"
    ranges.push to: "now-1h/h", from: "now-2h/h"
    ranges.push to: "now-2h/h", from: "now-3h/h"
    query.aggs.group_by_date.date_range.ranges = ranges
    return query

module.exports = FlowDeployOverTime
