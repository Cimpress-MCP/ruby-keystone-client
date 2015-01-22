require "keystone/v2_0/manager/base"

module Keystone
  module V2_0
    module Manager
      class Role < Keystone::V2_0::Manager::Base
        @@url_endpoint = "/OS-KSADM/roles"

        def initialize(auth_url)
          super auth_url, @@url_endpoint
        end

        def list
          # TODO: Get complete list from Keystone
          self
        end
      end
    end
  end
end
