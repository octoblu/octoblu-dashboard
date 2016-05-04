Backbone = require 'backbone'
_ = require 'lodash'
moment = require 'moment'
FLOW_DEPLOY_AVG_ELAPSED_TIME_QUERY = require '../queries/flow-deploy-avg-elapsed-time.json'

class DeployAvgElapsedTime extends Backbone.Model
  defaults:
    inLast: '1d'

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
    inLast = @get 'inLast'
    time = parseInt _.first inLast.match /\d+/
    timeUnit = _.first inLast.match /[a-zA-Z]+/

    yesterday = moment().subtract(time, timeUnit)
    query = _.cloneDeep FLOW_DEPLOY_AVG_ELAPSED_TIME_QUERY
    query.aggs.finished.filter.range.beginTime.gte = yesterday.unix()
    query

module.exports = DeployAvgElapsedTime
