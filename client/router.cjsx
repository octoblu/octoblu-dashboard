React  = require 'react'
Router = require 'react-router'
{Route, DefaultRoute, NotFoundRoute} = Router

App = require './app'
FlowDashboard = require './components/flow-dashboard'
FlowDeployment = require './components/flow-deployment'
FlowDeploymentAggs = require './components/flow-deployment-aggs'

routes =
  <Route handler={App} path="/">
    <DefaultRoute handler={FlowDashboard} />
    <NotFoundRoute handler={FlowDashboard} />
    <Route name="flow-deployment" path="/flow-deployments/:uuid/?" handler={FlowDeployment} />
    <Route name="flow-deployment-aggs" path="/flow-deployments/?" handler={FlowDeploymentAggs} />
  </Route>

Router.run routes, (Handler, state) ->
  React.render(<Handler query={state.query} />, document.getElementById('app'))
