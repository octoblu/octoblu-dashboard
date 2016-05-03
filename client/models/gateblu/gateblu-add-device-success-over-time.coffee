Backbone = require 'backbone'
_ = require 'lodash'
moment = require 'moment'
GATEBLU_ADD_DEVICE_SUCCESS_OVER_TIME = require '../../queries/gateblu/gateblu-add-device-success-over-time.json'

class GatebluAddDeviceSuccessOverTime extends Backbone.Model

  initialize: (attributes={}) =>
    index = attributes.index
    @url = "http://searchonly:q1c5j3slso793flgu0@0b0a9ec76284a09f16e189d7017ad116.us-east-1.aws.found.io:9200/#{index}_history/_search"

  parse: (response) =>
    buckets = response.aggregations.group_by_date.beginTime_over_time.buckets

    result = _.map buckets, @parseBucket
    return @formatResults result

  parseBucket: (bucket) =>
    successBuckets = _.filter bucket.group_by_success.buckets, key: 'T'
    failureBuckets = _.filter bucket.group_by_success.buckets, key: 'F'

    addCount = (count, bucket) =>
      return count += bucket.doc_count

    successCount = _.reduce successBuckets, addCount, 0
    failureCount = _.reduce failureBuckets, addCount, 0

    successPercentage = (successCount / (successCount + failureCount)) * 100
    successPercentage = 100 if successCount == 0 && failureCount == 0

    data =
      key: bucket.key
      successPercentage: successPercentage
      failureCount: _.findWhere bucket.group_by_success.buckets, key: 'F'
    return data

  formatResults: (results=[]) =>
    chartData = {}

    chartData.labels = _.pluck results, 'key'
    chartData.labels = _.map chartData.labels, (label) =>
      moment(moment.utc(label).toDate()).format 'hA'

    points = []
    _.each results, (result) =>
      points.push result.successPercentage
    chartData.datasets = [data: points]

    return chartData


  fetch: (options={}) =>
    defaults =
      type: 'POST'
      data: JSON.stringify @query()
      contentType: 'application/json'
    super _.defaults {}, options, defaults

  query: =>
    query = _.cloneDeep GATEBLU_ADD_DEVICE_SUCCESS_OVER_TIME
    query.aggs.group_by_date.filter.range.beginTime.gte = moment().subtract(1, 'day').valueOf()
    query.aggs.group_by_date.filter.range.beginTime.lte = moment().valueOf()
    return query

module.exports = GatebluAddDeviceSuccessOverTime
