require "keystone/v2_0/manager/base"

module Keystone
  module V2_0
    module Manager
      class Service < Keystone::V2_0::Manager::Base
        @@url_endpoint = "/OS-KSADM/services"

        def initialize
          super @@url_endpoint
        end
      end
    end
  end
end
