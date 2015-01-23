require "rest-client"

module Keystone
  module V2_0
    module Manager
      class Base
        attr_accessor :auth_url
        attr_accessor :url_endpoint
        attr_accessor :json_key
        attr_accessor :token

        def initialize(auth_url, url_endpoint, json_key)
          self.auth_url     = auth_url
          self.url_endpoint = url_endpoint
          self.json_key     = json_key
        end

        protected

        def list
          options                           = {}
          options[:url]                     = "#{self.auth_url.sub(/\/$/, '')}/#{self.url_endpoint}"
          options[:method]                  = :get
          options[:headers]                 = {}
          options[:headers]["X-Auth-Token"] = self.token
          options[:headers]["User-Agent"]   = "keystone-client"
          options[:headers]["Accept"]       = "application/json"
          options[:headers]["Content-Type"] = "application/json"

          # provide a block to ensure the response is parseable rather than
          # having RestClient throw an exception
          RestClient::Request.execute(options) do |response, request, result|
            if response and response.code == 200
              return JSON.parse(response.body)
            else
              return nil
            end
          end
        end
      end
    end
  end
end
