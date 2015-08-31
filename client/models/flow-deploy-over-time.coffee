Backbone = require 'backbone'
_ = require 'lodash'
moment = require 'moment'
FLOW_DEPLOY_STATUS_QUERY = require '../queries/flow-deploy-status.json'

class FlowDeployOverTime extends Backbone.Model
  url: "http://searchonly:q1c5j3slso793flgu0@0b0a9ec76284a09f16e189d7017ad116.us-east-1.aws.found.io:9200/flow_deploy_history/_search?search_type=count"

  parse: (response) =>
    flowStart = _.findWhere response.aggregations.filter_by_timestamp.group_by_workflow.buckets, key: 'flow-start'
    flowStart ?= {}
    return {}

  fetch: (options={}) =>
    defaults =
      type: 'POST'
      data: JSON.stringify @query()
      contentType: 'application/json'
    super _.defaults {}, options, defaults

  query: =>
    yesterday = moment().subtract(1, 'day')
    query = _.cloneDeep FLOW_DEPLOY_STATUS_QUERY
    query.aggs.filter_by_timestamp.filter.range._timestamp.gte = yesterday.valueOf()
    query

module.exports = FlowDeployOverTime
