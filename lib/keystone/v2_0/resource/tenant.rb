require "keystone/v2_0/resource/base"

module Keystone
  module V2_0
    module Resource
      class Tenant < Keystone::V2_0::Resource::Base
        attr_accessor :id
        attr_accessor :name
        attr_accessor :description
        attr_accessor :enabled

        @@attr_mappings = { "id"          => :id,
                            "name"        => :name,
                            "description" => :description,
                            "enabled"     => :enabled }

        def self.attr_mappings
          @@attr_mappings
        end
      end
    end
  end
end
