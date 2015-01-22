require "keystone/v2_0/version"
require "keystone/v2_0/manager/user"
require "keystone/v2_0/manager/role"
require "keystone/v2_0/manager/tenant"
require "keystone/v2_0/manager/service"
require "keystone/v2_0/manager/endpoint"
require "rest-client"
require "json"

module Keystone
  module V2_0
    class Client
      # client specific attributes
      attr_accessor :username
      attr_accessor :password
      attr_accessor :tenant_name
      attr_accessor :auth_url

      # query providers
      attr_accessor :user_manager
      attr_accessor :role_manager
      attr_accessor :tenant_manager
      attr_accessor :service_manager
      attr_accessor :endpoint_manager

      # create a new Keystone client instance with the given credentials
      def initialize(username, password, tenant_name, auth_url)
        # initialize the object
        self.username    = username
        self.password    = password
        self.tenant_name = tenant_name
        self.auth_url    = auth_url

        # create the initial query managers
        self.user_manager     = Keystone::V2_0::Manager::User.new     auth_url
        self.role_manager     = Keystone::V2_0::Manager::Role.new     auth_url
        self.tenant_manager   = Keystone::V2_0::Manager::Tenant.new   auth_url
        self.service_manager  = Keystone::V2_0::Manager::Service.new  auth_url
        self.endpoint_manager = Keystone::V2_0::Manager::Endpoint.new auth_url

        # create the manager methods through which queries will be performed
        # using meta-programming to ensure DRY principle is followed
        [ "users", "roles", "tenants", "services", "endpoints" ].each do |query|
          self.class.send(:define_method, query) do
            unless (token = get_token).nil?
              singular_method = query.sub(/s$/, '')
              self.send("#{singular_method}_manager").token = token
              return self.send("#{singular_method}_manager").send(query)
            else
              raise "An exception has occurred attempting to invoke '#{query}'"
            end
          end
        end
      end

      private

      # obtain a token for the action being performed
      def get_token
        options                           = {}
        options[:url]                     = self.auth_url + "/tokens"
        options[:method]                  = :post
        options[:headers]                 = {}
        options[:headers]["User-Agent"]   = "keystone-client"
        options[:headers]["Accept"]       = "application/json"
        options[:headers]["Content-Type"] = "application/json"
        options[:payload]                 = { "auth" =>
                                              { "tenantName" => self.tenant_name,
                                                "passwordCredentials" =>
                                                {
                                                  "username" => self.username,
                                                  "password" => self.password
                                                }
                                              }
                                            }.to_json

        # provide a block to ensure the response is parseable rather than
        # having RestClient throw an exception
        RestClient::Request.execute(options) do |response, request, result|
          if response and response.code == 200
            return JSON.parse(response.body)["access"]["token"]["id"]
          else
            return nil
          end
        end
      end
    end
  end
end
