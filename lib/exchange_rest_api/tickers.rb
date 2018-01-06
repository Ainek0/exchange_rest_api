module Tickers

  class Base
    attr_reader :message

    def initialize(message)
      @message = message
    end
  end

  class Bittrex < Base

    def data
      if message['succes']
        {
          bid: message['Bid'],
          ask: message['Ask'],
          last: message['Last']
        }
      else
        raise "APIError #{message}"
      end
    end

  end

  class Bitfinex < Base
    def data
      {}
    end
  end

end
