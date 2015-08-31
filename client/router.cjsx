React  = require 'react'
Router = require 'react-router'
{Route, DefaultRoute, NotFoundRoute} = Router

App = require './app'
DashboardController = require './components/dashboard.controller'
FlowOverTime = require './components/flow-over-time/flow-over-time'

routes =
  <Route handler={App} path="/">
    <DefaultRoute handler={DashboardController} />
    <Route name="cheese" handler={FlowOverTime} />
    <NotFoundRoute handler={DashboardController} />
  </Route>

Router.run routes, (Handler) ->
  React.render(<Handler/>, document.getElementById('app'))
