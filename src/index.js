// eslint-disable-next-line no-global-assign
require = require('esm')(module /* , options */)
const dotenv = require('dotenv')

dotenv.config()

module.exports = require('./app.js')
