Backbone = require 'backbone'
_ = require 'lodash'
moment = require 'moment'
GATEBLU_ADD_DEVICE_SUCCESS_AVG_ELAPSED_TIME_OVER_TIME_QUERY = require '../../queries/gateblu/gateblu-add-device-avg-elapsed-time-over-time.json'

class GatebluAddDeviceSuccessAvgElapsedTimeOverTime extends Backbone.Model

  initialize: (attributes={}) =>
    index = attributes.index
    @url = "http://searchonly:q1c5j3slso793flgu0@0b0a9ec76284a09f16e189d7017ad116.us-east-1.aws.found.io:9200/#{index}_history/_search"

  parse: (response) =>
    buckets = _.map response.aggregations.finished.startTime_over_time.buckets, (bucket) =>
      elapsedTime: bucket.avgElapsedTime.value
      key: bucket.key_as_string

    labels = _.pluck buckets, 'key'
    data = _.map buckets, (bucket) => Math.round(bucket.elapsedTime / 1000)

    {
      labels: labels
      datasets: [
        {
          data: data
        }
      ]
    }

  fetch: (options={}) =>
    super _.defaults({}, options,
      type: 'POST'
      data: JSON.stringify(@query())
      contentType: 'application/json'
    )

  query: =>
    yesterday = moment().subtract(1, 'day')
    query = _.cloneDeep GATEBLU_ADD_DEVICE_SUCCESS_AVG_ELAPSED_TIME_OVER_TIME_QUERY
    query.aggs.finished.filter.range.beginTime.gte = yesterday.valueOf()
    query

module.exports = GatebluAddDeviceSuccessAvgElapsedTimeOverTime
