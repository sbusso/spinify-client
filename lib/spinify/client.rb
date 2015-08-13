require 'httparty'


# Spinify client to connect to API

module Spinify
  class Client
    # Say hi to the world!
    #
    # Example:
    #   >> Spinify::Client.new(id, key).multi(5).get(variables)
    #   => spuns...
    #
    # Arguments:
    #   id: (String)
    #   key: (String)
    #   number: (String)
    #   variables: (Hash)
    include HTTParty
    base_uri 'http://spinify.apps.turfmedia.com'

    def initialize(id,key)
      options[:body].merge({
        id: id,
        api_key: key
        })
      return self
    end

    def multi(number,n=nil)
      n ||= number*20
      options[:body].merge({
        multi: true,
        number: number,
        n: n
      })
      return self
    end


    def get(variables)
      options[:body]['variables'] = variables
      response = self.class.post('/api', options)
      response
    end

    private

    def options
      @options ||= {
        headers: {
          "charset" => 'UTF-8', "Content-Type" => 'application/x-www-form-urlencoded' #application/json
        },
        body: {}
      }
    end

  end
end
