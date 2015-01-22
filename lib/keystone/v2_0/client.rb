require "keystone/v2_0/version"
require "keystone/v2_0/manager/user"
require "keystone/v2_0/manager/role"
require "keystone/v2_0/manager/tenant"
require "keystone/v2_0/manager/service"
require "keystone/v2_0/manager/endpoint"

module Keystone
  module V2_0
    class Client
      # client specific attributes
      attr_accessor :username
      attr_accessor :password
      attr_accessor :tenant_name
      attr_accessor :auth_url

      # query providers
      attr_accessor :users
      attr_accessor :roles
      attr_accessor :tenants
      attr_accessor :services
      attr_accessor :endpoints

      # create a new Keystone client instance with the given credentials
      def initialize(username, password, tenant_name, auth_url)
        # initialize the object
        self.username    = username
        self.password    = password
        self.tenant_name = tenant_name
        self.auth_url    = auth_url

        # create the initial query managers
        self.users     = Keystone::V2_0::Manager::User.new
        self.roles     = Keystone::V2_0::Manager::Role.new
        self.tenants   = Keystone::V2_0::Manager::Tenant.new
        self.services  = Keystone::V2_0::Manager::Service.new
        self.endpoints = Keystone::V2_0::Manager::Endpoint.new
      end
    end
  end
end
