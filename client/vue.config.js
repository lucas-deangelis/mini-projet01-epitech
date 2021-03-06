// vue.config.js

const jquery = require('jquery')
const path = require('path')


module.exports = {
  chainWebpack: config => {
    const types = ['vue-modules', 'vue', 'normal-modules', 'normal']
    types.forEach(type => addStyleResource(config.module.rule('stylus').oneOf(type)))

    config.plugin('env').use(require.resolve('webpack/lib/ProvidePlugin'), [{
      $: 'jquery',
      jquery: 'jquery',
      'window.jQuery': 'jquery',
      jQuery: 'jquery'
    }])

  },
}

function addStyleResource (rule) {
  rule.use('style-resource')
    .loader('style-resources-loader')
    .options({
      patterns: [
        path.resolve(__dirname, './src/assets/css/style.styl'),
        path.resolve(__dirname, './src/assets/css/transition.styl'),
      ],
    })
}
  