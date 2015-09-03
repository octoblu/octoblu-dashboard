Backbone = require 'backbone'
_ = require 'lodash'
moment = require 'moment'
FLOW_DEPLOY_AVG_ELAPSED_TIME_QUERY = require '../queries/flow-deploy-avg-elapsed-time.json'

class DeployAvgElapsedTime extends Backbone.Model

  initialize: (attributes={}) =>
    index = attributes.index
    @url = "http://searchonly:q1c5j3slso793flgu0@0b0a9ec76284a09f16e189d7017ad116.us-east-1.aws.found.io:9200/#{index}_history/_search"

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
    query = _.cloneDeep FLOW_DEPLOY_AVG_ELAPSED_TIME_QUERY
    query.aggs.finished.filter.range.beginTime.gte = yesterday.valueOf()
    query

module.exports = DeployAvgElapsedTime