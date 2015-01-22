require "keystone/v2_0/manager/base"

module Keystone
  module V2_0
    module Manager
      class Role < Keystone::V2_0::Manager::Base
        @@url_endpoint = "OS-KSADM/roles"
        @@json_key     = "roles"

        def initialize(auth_url)
          super auth_url, @@url_endpoint, @@json_key
        end

        def roles
          return self.class.superclass.instance_method(:list).bind(self).call
        end
      end
    end
  end
end
