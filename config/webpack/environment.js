const { environment } = require('@rails/webpacker')
const typescript =  require('./loaders/typescript')
const erb = require('./loaders/erb')

const webpack = require("webpack");

environment.plugins.append(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
    Popper: ["popper.js", "default"],
    Rails: ['rails-ujs-confirm']
  })
);

environment.loaders.prepend('erb', erb)
environment.loaders.prepend('typescript', typescript)
module.exports = environment
