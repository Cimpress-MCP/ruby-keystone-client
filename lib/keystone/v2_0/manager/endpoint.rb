require "keystone/v2_0/manager/base"
require "keystone/v2_0/resource/endpoint"

module Keystone
  module V2_0
    module Manager
      class Endpoint < Keystone::V2_0::Manager::Base
        @@url_endpoint = "endpoints"
        @@json_key     = "endpoints"

        def initialize(auth_url)
          super auth_url, @@url_endpoint, @@json_key
        end

        def list
          endpoints     = super
          endpoint_list = []

          # map role hash to array of Endpoint objects
          unless endpoints.nil?
            endpoints[@@json_key].each do |endpoint_data|
              endpoint_resource = Keystone::V2_0::Resource::Endpoint.new(endpoint_data)
              endpoint_list << endpoint_resource
            end

            return endpoint_list
          else
            return nil
          end
        end
      end
    end
  end
end
