require 'httparty'


# Spinify client to connect to API

module Spinify
  class Client
    # Say hi to the world!
    #
    # Example:
    #   >> Spinify::Client.new(id, key).multi(5).set('formula', "{{>forme_positive}}").variables(vars).get
    #   => spuns...
    #
    # Arguments:
    #   id: (String)
    #   key: (String)
    #   number: (String)
    #   variables: (Hash)
    include HTTParty


    def initialize(id,key, uri = 'http://spinify.apps.turfmedia.com')
      @base_uri = uri
      options[:body].merge!({
        id: id,
        auth_key: key
        })
      return self
    end

    def multi(number,n=nil)
      n ||= number*20
      options[:body].merge!({
        multi: true,
        number: number,
        n: n
      })
      return self
    end

    def set(key, value)
      options[:body][key] = value
      return self
    end

    def variables(vars)
      options[:body]['variables'] = vars
      return self
    end

    def get
      response = self.class.post(@base_uri + '/api', options)
      response
    end

    private

    def options
      @options ||= {
        headers: {
          "charset" => 'UTF-8', "Content-Type" => 'application/x-www-form-urlencoded' #'application/json'#
        },
        body: {}
      }
    end

  end
end
