Backbone = require 'backbone'
_ = require 'lodash'
moment = require 'moment'
GATEBLU_ADD_DEVICE_SUCCESS_AVG_ELAPSED_TIME_OVER_TIME_QUERY = require '../../queries/gateblu/gateblu-add-device-avg-elapsed-time-over-time.json'

class GatebluAddDeviceSuccessAvgElapsedTimeOverTime extends Backbone.Model

  initialize: (attributes={}) =>
    index = attributes.index
    @url = "http://readonly:hfpxaq4e7k6gimwcwl@6afa8b1002a9aae2191763621313e6ea.us-west-1.aws.found.io:9200/#{index}_history/_search"

  parse: (response) =>
    buckets = _.map response.aggregations.finished.startTime_over_time.buckets, (bucket) =>
      elapsedTime: bucket.avgElapsedTime.value
      key: bucket.key

    labels = _.pluck buckets, 'key'
    labels = _.map labels, (label) =>
      moment(moment.utc(label).toDate()).format 'hA'
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
    query.aggs.finished.filter.range.beginTime.gte = yesterday.unix()
    query

module.exports = GatebluAddDeviceSuccessAvgElapsedTimeOverTime
