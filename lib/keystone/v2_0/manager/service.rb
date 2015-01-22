require "keystone/v2_0/manager/base"
require "keystone/v2_0/resource/service"

module Keystone
  module V2_0
    module Manager
      class Service < Keystone::V2_0::Manager::Base
        @@url_endpoint = "OS-KSADM/services"
        @@json_key     = "OS-KSADM:services"

        def initialize(auth_url)
          super auth_url, @@url_endpoint, @@json_key
        end

        def services
          service_list = []
          services     = self.class.superclass.instance_method(:list).bind(self).call

          # map role hash to array of Service objects
          unless services.nil?
            services[@@json_key].each do |service_data|
              service_resource = Keystone::V2_0::Resource::Service.new(service_data)
              service_list << service_resource
            end

            return service_list
          else
            return nil
          end
        end
      end
    end
  end
end
