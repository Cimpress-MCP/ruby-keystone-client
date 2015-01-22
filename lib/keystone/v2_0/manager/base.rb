module Keystone
  module V2_0
    module Manager
      class Base
        attr_accessor :auth_url
        attr_accessor :url_endpoint
        attr_accessor :token

        def initialize(auth_url, url_endpoint)
          self.auth_url     = auth_url
          self.url_endpoint = url_endpoint
        end
      end
    end
  end
end
