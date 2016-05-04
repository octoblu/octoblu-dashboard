Backbone = require 'backbone'
_ = require 'lodash'
moment = require 'moment'
FLOW_DEPLOY_AVG_ELAPSED_TIME_OVER_TIME_QUERY = require '../queries/flow-deploy-avg-elapsed-time-over-time.json'

class DeployAvgElapsedTimeOverTime extends Backbone.Model
  defaults:
    inLast: '1d'
    byUnit: 'hour'

  initialize: (attributes={}) =>
    index = attributes.index
    @url = "http://readonly:hfpxaq4e7k6gimwcwl@6afa8b1002a9aae2191763621313e6ea.us-west-1.aws.found.io:9200/#{index}_history/_search"

  parse: (response) =>
    buckets = _.map response.aggregations.finished.startTime_over_time.buckets, (bucket) =>
      elapsedTime: bucket.avgElapsedTime.value
      key: bucket.key

    labels = _.pluck buckets, 'key'
    labels = _.map labels, (label) =>
      moment(moment.utc(label).toDate()).format @chartDateFormat()
    data = _.map buckets, (bucket) => Math.round(bucket.elapsedTime / 1000)

    elapsedTimeChartData:
      labels: labels
      datasets: [
        {
          data: data
        }
      ]

  fetch: (options={}) =>
    super _.defaults({}, options,
      type: 'POST'
      data: JSON.stringify(@query())
      contentType: 'application/json'
    )

  query: =>
    {inLast, byUnit} = @toJSON()
    time = parseInt _.first inLast.match /\d+/
    timeUnit = _.first inLast.match /[a-zA-Z]+/

    yesterday = moment().subtract(time, timeUnit)
    query = _.cloneDeep FLOW_DEPLOY_AVG_ELAPSED_TIME_OVER_TIME_QUERY
    query.aggs.finished.filter.range.beginTime.gte = yesterday.valueOf()
    query.aggs.finished.aggs.startTime_over_time.date_histogram.interval = byUnit
    query

  chartDateFormat: =>
    return 'hA' if @get('byUnit') == 'hour'
    return 'ddd'

module.exports = DeployAvgElapsedTimeOverTime
