Backbone = require 'backbone'

class FlowDeploymentStep extends Backbone.Model
  parse: (data) =>
    {
      label:  "#{data.workflow} (#{(data.elapsedTime / 1000).toFixed(2)}s)"
      offset: data.beginOffset
      width:  data.elapsedTime
    }

module.exports = FlowDeploymentStep
