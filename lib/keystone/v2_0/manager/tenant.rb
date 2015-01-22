require "keystone/v2_0/manager/base"

module Keystone
  module V2_0
    module Manager
      class Tenant < Keystone::V2_0::Manager::Base
        @@url_endpoint = "/tenants"

        def initialize
          super @@url_endpoint
        end
      end
    end
  end
end
