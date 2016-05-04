Backbone = require 'backbone'
_ = require 'lodash'
moment = require 'moment'
GATEBLU_ADD_DEVICE_STATUS_QUERY = require '../../queries/gateblu/gateblu-add-device-status.json'

class GatebluAddDeviceStatus extends Backbone.Model

  initialize: (attributes={}) =>
    index = attributes.index
    @url = "http://readonly:hfpxaq4e7k6gimwcwl@6afa8b1002a9aae2191763621313e6ea.us-west-1.aws.found.io:9200/#{index}_history/_search"


  parse: (response) =>
    addDeviceStart = _.findWhere response.aggregations.filter_by_timestamp.group_by_workflow.buckets
    addDeviceStart ?= {}


    successes = _.find(addDeviceStart.group_by_success?.buckets, key: 'T')?.doc_count ? 0
    failures  = _.find(addDeviceStart.group_by_success?.buckets, key: 'F')?.doc_count ? 0
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
    query = _.cloneDeep GATEBLU_ADD_DEVICE_STATUS_QUERY
    query.aggs.filter_by_timestamp.filter.range.beginTime.gte = yesterday.unix()
    query.aggs.filter_by_timestamp.filter.range.beginTime.lte = five_minutes_ago.unix()
    query

module.exports = GatebluAddDeviceStatus
