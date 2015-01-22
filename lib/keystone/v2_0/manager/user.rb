require "keystone/v2_0/manager/base"

module Keystone
  module V2_0
    module Manager
      class User < Keystone::V2_0::Manager::Base
        @@url_endpoint = "/users"

        def initialize
          super @@url_endpoint
        end
      end
    end
  end
end
