Backbone = require 'backbone'

class FlowDeploymentStep extends Backbone.Model
  parse: (data) =>
    console.log JSON.stringify data
    {
      label:  "#{data.workflow} (#{(data.elapsedTime / 1000).toFixed(2)}s)"
      offset: data.beginOffset
      width:  data.elapsedTime
    }

module.exports = FlowDeploymentStep
