module ExchangeRestApi
  class Ticker
    attr_reader :metadata, :exchange, :message

    EXCHANGE_MAPPING = {
      'bittrex' => Tickers::Bittrex,
      'bitfinex' => Tickers::Bitfinex
    }

    def initialize(messages)
      @metadata = messages[0]
      @exchange = EXCHANGE_MAPPING[metadata['exchange']]
      metadata['timestamp'] = Time.at(messages[1].to_f)
      @message = messages[2]
    end

    def data
      d = exchange.new(message).data
      metadata.merge(d)
    rescue RuntimeError => e
      puts e
    end

  end
end
