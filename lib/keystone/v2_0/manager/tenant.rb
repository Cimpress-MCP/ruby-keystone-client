require "keystone/v2_0/manager/base"

module Keystone
  module V2_0
    module Manager
      class Tenant < Keystone::V2_0::Manager::Base
        @@url_endpoint = "/tenants"

        def initialize(auth_url)
          super auth_url, @@url_endpoint
        end

        def tenants
          tenants = self.class.superclass.instance_method(:list).bind(self).call
          tenants ? tenants["tenants"] : nil
        end
      end
    end
  end
end
