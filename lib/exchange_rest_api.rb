require "exchange_rest_api/version"
require_relative "exchange_rest_api/bittrex"
require_relative "exchange_rest_api/bitfinex"
require_relative "exchange_rest_api/endpoint"
require_relative "exchange_rest_api/normalisation"
require_relative "exchange_rest_api/ticker"
require_relative "exchange_rest_api/market"

module ExchangeRestApi
  include Api
  include Normalisation
end
