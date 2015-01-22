require "keystone/v2_0/manager/base"

module Keystone
  module V2_0
    module Manager
      class User < Keystone::V2_0::Manager::Base
        @@url_endpoint = "users"
        @@json_key     = "users"

        def initialize(auth_url)
          super auth_url, @@url_endpoint, @@json_key
        end

        def users
          return self.class.superclass.instance_method(:list).bind(self).call
        end
      end
    end
  end
end
