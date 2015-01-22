require "keystone/v2_0/manager/base"

module Keystone
  module V2_0
    module Manager
      class Endpoint < Keystone::V2_0::Manager::Base
        @@url_endpoint = "/endpoints"

        def initialize(auth_url)
          super auth_url, @@url_endpoint
        end

        def endpoints
          endpoints = self.class.superclass.instance_method(:list).bind(self).call
          endpoints ? endpoints["endpoints"] : nil
        end
      end
    end
  end
end
