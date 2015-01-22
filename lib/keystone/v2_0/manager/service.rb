require "keystone/v2_0/manager/base"

module Keystone
  module V2_0
    module Manager
      class Service < Keystone::V2_0::Manager::Base
        @@url_endpoint = "/OS-KSADM/services"

        def initialize(auth_url)
          super auth_url, @@url_endpoint
        end

        def services
          services = self.class.superclass.instance_method(:list).bind(self).call
          services ? services["services"] : nil
        end
      end
    end
  end
end
