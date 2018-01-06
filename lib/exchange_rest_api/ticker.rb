module ExchangeRestApi
  class Ticker
    attr_reader :metadata, :exchange, :timestamp, :message

    EXCHANGE_MAPPING = {
      'bittrex' => Tickers::Bittrex,
      'bitfinex' => Tickers::Bitfinex
    }

    def initialize(messages)
      @metadata = messages[0]
      @exchange = EXCHANGE_MAPPING[metadata['exchange']]
      @timestamp = Time.at(messages[1].to_f)
      @message = messages[2]
    end

    def data
      metadata.merge(exchange.new(message).data)
    end

  end
end
