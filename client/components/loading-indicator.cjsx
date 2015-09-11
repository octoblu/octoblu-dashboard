React = require 'react'

LoadingIndicator = React.createClass
  displayName: 'LoadingIndicator'

  render: ->
    <div className="LoadingIndicator">
      <p>Loading...</p>
    </div>

module.exports = LoadingIndicator
