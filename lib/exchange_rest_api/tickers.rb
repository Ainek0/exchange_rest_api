module Tickers

  class Base
    attr_reader :message

    def initialize(message)
			@message = message
    end
  end

  class Bittrex < Base

    def data
      raise "APIError #{self.message}" if !self.message['success']

      message = self.message['result']

      {
        bid: message['Bid'],
        ask: message['Ask'],
        last: message['Last']
      }
    end

  end

  class Bitfinex < Base
    def data
      raise "APIError #{message['error']}" if message['error']

      {
        bid: message['bid'],
        ask: message['ask'],
        last: message['last_price']
      }
    end
  end

end
