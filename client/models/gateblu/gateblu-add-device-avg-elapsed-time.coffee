Backbone = require 'backbone'
_ = require 'lodash'
moment = require 'moment'
GATEBLU_ADD_DEVICE_AVG_ELAPSED_TIME_QUERY = require '../../queries/gateblu/gateblu-add-device-avg-elapsed-time.json'

class GatebluAddDeviceAvgElapsedTime extends Backbone.Model

  initialize: (attributes={}) =>
    index = attributes.index
    @url = "http://readonly:hfpxaq4e7k6gimwcwl@6afa8b1002a9aae2191763621313e6ea.us-west-1.aws.found.io:9200/#{index}_history/_search"

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
    query = _.cloneDeep GATEBLU_ADD_DEVICE_AVG_ELAPSED_TIME_QUERY
    query.aggs.finished.filter.range.beginTime.gte = yesterday.valueOf()
    query

module.exports = GatebluAddDeviceAvgElapsedTime
