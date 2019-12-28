var HtmlWebpackPlugin = require('html-webpack-plugin')
var path = require('path')

const MODE = 'development'

const enableSourceMap = MODE === 'development'

module.exports = {
  mode: MODE,

  entry: {
    app: ['./src/js/index.js']
  },

  output: {
    filename: 'index_bundle.js',
    path: path.resolve(__dirname, 'dist')
  },

  module: {
    rules: [
      {
        test: /\.css$/,
        use: [
          'style-loader',
          {
            loader: 'css-loader',
            options: {
              url: false,
              sourceMap: enableSourceMap
            }
          }
        ]
      },
      {
        test: /\.scss$/,
        use: [
          'style-loader',
          {
            loader: 'css-loader',
            options: {
              url: false,
              sourceMap: enableSourceMap,

              // 0 => no loaders (default);
              // 1 => postcss-loader;
              // 2 => postcss-loader, sass-loader
              importLoaders: 2
            }
          },
          {
            loader: 'sass-loader',
            options: {
              sourceMap: enableSourceMap
            }
          }
        ]
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: [
          { loader: 'elm-hot-webpack-loader' },
          {
            loader: 'elm-webpack-loader',
            options: {}
          }
        ]
      }
    ],
    noParse: [/.elm$/]
  },

  plugins: [
    new HtmlWebpackPlugin({
      filename: 'index.html',
      template: './src/html/index.html',
      inject: 'body'
    })
  ]
}
