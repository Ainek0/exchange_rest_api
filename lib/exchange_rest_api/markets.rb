module Markets

  class Base
    attr_reader :normalised_name

    def initialize(normalised_name)
      @normalised_name = normalised_name
    end

  end

  class Bittrex < Base

    # TODO Implement better mapping algo 
    # instead of mapping all narkets
    def name
      mapping[normalised_name] || normalised_name
    end

    def mapping
      {
        'USD-BTC' =>  'USDT-BTC'
      }
    end

  end

  class Bitfinex < Base

    def name
      normalised_name.split('-').reverse.join.downcase
    end

  end

end
