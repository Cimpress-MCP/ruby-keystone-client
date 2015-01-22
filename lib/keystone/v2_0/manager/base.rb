module Keystone
  module V2_0
    module Manager
      class Base
        attr_accessor :url_endpoint

        def initialize(url_endpoint)
          self.url_endpoint = url_endpoint
        end
      end
    end
  end
end
