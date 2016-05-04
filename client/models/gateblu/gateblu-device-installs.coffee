Backbone = require 'backbone'
_ = require 'lodash'
moment = require 'moment'
GATEBLU_DEVICE_INSTALLS_QUERY = require '../../queries/gateblu/gateblu-device-installs.json'

class GatebluDeviceInstalls extends Backbone.Model

  initialize: (attributes={}) =>
    index = attributes.index
    @url = "http://searchonly:hfpxaq4e7k6gimwcwl@6afa8b1002a9aae2191763621313e6ea.us-west-1.aws.found.io:9200/#{index}_history/_search"

  parse: (response) =>
    devices = response.aggregations.group_by_connector.buckets
    devices ?= []

    devices: _.map devices, @normalize

  normalize: (device) =>
    successes = device.group_by_succeses.buckets[0].key
    failures = device.group_by_failures.buckets[0].key
    total = successes + failures

    if total > 0
      successRate = (1.0 * successes) / total
    else
      successRate = 1

    name: device.key
    total: total
    successes: successes
    failures: failures
    successPercentage: 100 * successRate

  fetch: (options={}) =>
    super _.defaults({}, options,
      type: 'POST'
      data: JSON.stringify(@query())
      contentType: 'application/json'
    )

  query: =>
    yesterday = moment().subtract(1, 'day')
    five_minutes_ago = moment().subtract(5, 'minutes')
    query = _.cloneDeep GATEBLU_DEVICE_INSTALLS_QUERY
    query

module.exports = GatebluDeviceInstalls
