Backbone = require 'backbone'
_ = require 'lodash'
moment = require 'moment'
FLOW_DEPLOY_STATUS_QUERY = require '../queries/flow-deploy-status.json'

class FlowDeployStatus extends Backbone.Model
  defaults:
    inLast: '1d'

  initialize: (attributes={}) =>
    index = attributes.index
    @url = "http://6afa8b1002a9aae2191763621313e6ea.us-west-1.aws.found.io:9200/#{index}_history/_search"

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
    inLast = @get 'inLast'
    query = _.cloneDeep FLOW_DEPLOY_STATUS_QUERY
    query.aggs.filter_by_timestamp.filter.range.beginTime.gte = "now-#{inLast}"
    query.aggs.filter_by_timestamp.filter.range.beginTime.lte = "now-5m"
    query

module.exports = FlowDeployStatus
