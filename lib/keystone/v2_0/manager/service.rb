require "keystone/v2_0/manager/base"

module Keystone
  module V2_0
    module Manager
      class Service < Keystone::V2_0::Manager::Base
        @@url_endpoint = "OS-KSADM/services"
        @@json_key     = "services"

        def initialize(auth_url)
          super auth_url, @@url_endpoint, @@json_key
        end

        def services
          return self.class.superclass.instance_method(:list).bind(self).call
        end
      end
    end
  end
end
