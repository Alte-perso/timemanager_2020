module.exports = {
  transpileDependencies: ["vuetify"],
  publicPath: "",

  pluginOptions: {
    cordovaPath: "front-mobile"
  }
};
const webpack = require("webpack");
module.exports = {
  configureWebpack: {
    plugins: [new webpack.ProvidePlugin({ jQuery: "jquery" })]
  },

  publicPath: "",

  pluginOptions: {
    cordovaPath: "front-mobile"
  }
};
