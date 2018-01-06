require "exchange_rest_api/version"
require_relative "exchange_rest_api/bittrex"
require_relative "exchange_rest_api/bitfinex"
require_relative "exchange_rest_api/endpoint"
require_relative "exchange_rest_api/tickers"
require_relative "exchange_rest_api/ticker"

module ExchangeRestApi
  include Api
  include Tickers
end
