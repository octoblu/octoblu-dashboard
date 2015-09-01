ghpages = require 'gh-pages'
path    = require 'path'


module.exports = (callback=->) =>
  publicPath = path.join __dirname, 'public'
  ghpages.publish publicPath, callback
