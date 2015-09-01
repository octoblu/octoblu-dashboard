React  = require 'react'
Router = require 'react-router'
{Route, DefaultRoute, NotFoundRoute} = Router

App = require './app'
FlowDashboard = require './components/flow-dashboard'
GatebluDashboard = require './components/gateblu-dashboard'

routes =
  <Route handler={App} path="/">
    <DefaultRoute handler={FlowDashboard} />
    <NotFoundRoute handler={FlowDashboard} />
    <Route name="gateblu-dashboard" path="/gateblu" handler={GatebluDashboard} />
  </Route>

Router.run routes, (Handler) ->
  React.render(<Handler/>, document.getElementById('app'))
