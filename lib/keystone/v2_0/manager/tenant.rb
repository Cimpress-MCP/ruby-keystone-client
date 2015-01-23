require "keystone/v2_0/manager/base"
require "keystone/v2_0/resource/tenant"

module Keystone
  module V2_0
    module Manager
      class Tenant < Keystone::V2_0::Manager::Base
        @@url_endpoint = "tenants"
        @@json_key     = "tenants"

        def initialize(auth_url)
          super auth_url, @@url_endpoint, @@json_key
        end

        def list
          tenants     = super
          tenant_list = []

          # map role hash to array of Tenant objects
          unless tenants.nil?
            tenants[@@json_key].each do |tenant_data|
              tenant_resource = Keystone::V2_0::Resource::Tenant.new(tenant_data)
              tenant_list << tenant_resource
            end

            return tenant_list
          else
            return nil
          end
        end
      end
    end
  end
end
