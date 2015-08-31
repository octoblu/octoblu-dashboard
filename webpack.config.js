var path = require('path');
var webpack = require('webpack');

module.exports = {
  entry: "./client/router.cjsx",
  output: {
    path: path.join(__dirname, "public", "dist"),
    filename: 'bundle.js'
  },
  resolveLoader: {
    modulesDirectories: ['node_modules']
  },
  resolve: {
    extensions: ['', '.js', '.cjsx', '.coffee', '.json']
  },
  module: {
    loaders: [
      { test: /\.cjsx$/, loaders: ['coffee', 'cjsx']},
      { test: /\.coffee$/, loader: 'coffee' },
      { test: /\.json$/, loader: 'json' }
    ]
  }
};
