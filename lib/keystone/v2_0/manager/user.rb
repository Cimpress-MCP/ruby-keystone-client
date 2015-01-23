require "keystone/v2_0/manager/base"
require "keystone/v2_0/resource/user"

module Keystone
  module V2_0
    module Manager
      class User < Keystone::V2_0::Manager::Base
        @@url_endpoint = "users"

        def initialize(auth_url)
          super auth_url, @@url_endpoint
        end

        def list
          users     = super
          user_list = []

          # map user hash to array of User objects
          unless users.nil?
            users["users"].each do |user_data|
              user_resource = Keystone::V2_0::Resource::User.new(user_data)
              user_list << user_resource
            end

            return user_list
          else
            return nil
          end
        end
      end
    end
  end
end
