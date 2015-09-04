React  = require 'react'
Router = require 'react-router'
{Route, DefaultRoute, NotFoundRoute} = Router

App = require './app'
FlowDashboard = require './components/flow-dashboard'
GatebluDashboard = require './components/gateblu-dashboard'
FlowDeployment = require './components/flow-deployment'
FlowDeploymentAggs = require './components/flow-deployment-aggs'

routes =
  <Route handler={App} path="/">
    <DefaultRoute handler={FlowDashboard} />
    <NotFoundRoute handler={FlowDashboard} />
    <Route name="gateblu-dashboard" path="/gateblu" handler={GatebluDashboard} />
    <Route name="flow-deployment" path="/flow-deployments/:uuid" handler={FlowDeployment} />
    <Route name="flow-deployment-aggs" path="/flow-deployments" handler={FlowDeploymentAggs} />
  </Route>

Router.run routes, (Handler) ->
  React.render(<Handler/>, document.getElementById('app'))
