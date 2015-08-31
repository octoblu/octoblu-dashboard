React  = require 'react'
Router = require 'react-router'
{Route, DefaultRoute, NotFoundRoute} = Router

App = require './app'
DashboardController = require './components/dashboard.controller'

console.log 'hello'

routes =
  <Route handler={App} path="/">
    <DefaultRoute handler={DashboardController} />
    <NotFoundRoute handler={DashboardController}/>
  </Route>

Router.run routes, (Handler) ->
  React.render(<Handler/>, document.getElementById('app'))
