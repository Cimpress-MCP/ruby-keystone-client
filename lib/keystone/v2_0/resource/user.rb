require "keystone/v2_0/resource/base"

module Keystone
  module V2_0
    module Resource
      class User < Keystone::V2_0::Resource::Base
        attr_accessor :id
        attr_accessor :username
        attr_accessor :name
        attr_accessor :enabled
        attr_accessor :email

        @@attr_mappings = { "id"       => :id,
                            "username" => :username,
                            "name"     => :name,
                            "enabled"  => :enabled,
                            "email"    => :email }

        def self.attr_mappings
          @@attr_mappings
        end
      end
    end
  end
end
