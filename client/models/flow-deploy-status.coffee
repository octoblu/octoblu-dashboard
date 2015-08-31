Backbone = require 'backbone'
_ = require 'lodash'
moment = require 'moment'
FLOW_DEPLOY_STATUS_QUERY = require '../queries/flow-deploy-status.json'

class FlowDeployStatus extends Backbone.Model
  url: "http://searchonly:q1c5j3slso793flgu0@0b0a9ec76284a09f16e189d7017ad116.us-east-1.aws.found.io:9200/flow_deploy_history/_search?search_type=count"

  parse: (response) =>
    flowStart = _.findWhere response.aggregations.filter_by_timestamp.group_by_workflow.buckets, key: 'flow-start'
    flowStart ?= {}

    successes = _.find(flowStart.group_by_success?.buckets, key: 'T')?.doc_count ? 0
    failures  = _.find(flowStart.group_by_success?.buckets, key: 'F')?.doc_count ? 0
    total     = successes + failures

    if total > 0
      successRate = (1.0 * successes) / total
      failureRate = (1.0 * failures) / total
    else
      successRate = 1
      failureRate = 0

    {
      successes: successes
      successRate: successRate
      successPercentage: 100 * successRate
      failures: failures
      failureRate: failureRate
      failurePercentage: 100 * failureRate
      total: total
    }

  fetch: (options={}) =>
    super _.defaults({}, options,
      type: 'POST'
      data: JSON.stringify(@query())
      contentType: 'application/json'
    )

  query: =>
    yesterday = moment().subtract(1, 'day')
    five_minutes_ago = moment().subtract(5, 'minutes')
    query = _.cloneDeep FLOW_DEPLOY_STATUS_QUERY
    query.aggs.filter_by_timestamp.filter.range.beginTime.gte = yesterday.valueOf()
    query.aggs.filter_by_timestamp.filter.range.beginTime.lte = five_minutes_ago.valueOf()
    query

module.exports = FlowDeployStatus
