require "keystone/v2_0/manager/base"
require "keystone/v2_0/resource/role"

module Keystone
  module V2_0
    module Manager
      class Role < Keystone::V2_0::Manager::Base
        @@url_endpoint = "OS-KSADM/roles"
        @@json_key     = "roles"

        def initialize(auth_url)
          super auth_url, @@url_endpoint, @@json_key
        end

        def list
          roles     = super
          role_list = []

          # map role hash to array of Role objects
          unless roles.nil?
            roles[@@json_key].each do |role_data|
              role_resource = Keystone::V2_0::Resource::Role.new(role_data)
              role_list << role_resource
            end

            return role_list
          else
            return nil
          end
        end
      end
    end
  end
end
