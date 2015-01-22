require "keystone/v2_0/resource/base"

module Keystone
  module V2_0
    module Resource
      class Endpoint < Keystone::V2_0::Resource::Base
        attr_accessor :id
        attr_accessor :service_id
        attr_accessor :region
        attr_accessor :admin_url
        attr_accessor :internal_url
        attr_accessor :public_url
        attr_accessor :enabled

        @@attr_mappings = { "id"          => :id,
                            "service_id"  => :service_id,
                            "region"      => :region,
                            "adminurl"    => :admin_url,
                            "internalurl" => :internal_url,
                            "publicurl"   => :public_url,
                            "enabled"     => :enabled }

        def self.attr_mappings
          @@attr_mappings
        end
      end
    end
  end
end
