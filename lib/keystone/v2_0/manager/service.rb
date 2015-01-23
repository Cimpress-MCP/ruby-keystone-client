require "keystone/v2_0/manager/base"
require "keystone/v2_0/resource/service"

module Keystone
  module V2_0
    module Manager
      class Service < Keystone::V2_0::Manager::Base
        @@url_endpoint = "OS-KSADM/services"

        def initialize(auth_url)
          super auth_url, @@url_endpoint
        end

        def list
          services     = super
          service_list = []

          # map role hash to array of Service objects
          unless services.nil?
            services["OS-KSADM:services"].each do |service_data|
              service_resource = Keystone::V2_0::Resource::Service.new(service_data)
              service_list << service_resource
            end

            return service_list
          else
            return nil
          end
        end

        def create(name: '', type: '', description: '')
          create_key = "OS-KSADM:service"
          payload = { create_key =>
                      { "name"        => name,
                        "type"        => type,
                        "description" => description
                      }
                    }
          service_data = super(payload.to_json)

          if service_data and service_data[create_key]
            return Keystone::V2_0::Resource::Service.new(service_data[create_key])
          else
            return nil
          end
        end
      end
    end
  end
end
