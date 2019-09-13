// vue.config.js

const path = require('path')

module.exports = {
  chainWebpack: config => {
    const types = ['vue-modules', 'vue', 'normal-modules', 'normal']
    types.forEach(type => addStyleResource(config.module.rule('stylus').oneOf(type)))

    config.plugin('define').tap(definitions => {
      definitions[0] = Object.assign(definitions[0], {
          $: 'jquery',
          jquery: 'jquery',
          'window.jQuery': 'jquery',
          jQuery: 'jquery',
          _: 'lodash'
      })
      return definitions
    })
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
  