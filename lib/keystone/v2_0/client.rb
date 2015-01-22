require "keystone/v2_0/version"

module Keystone
  module V2_0
    class Client
      # client specific attributes
      attr_accessor :username
      attr_accessor :password
      attr_accessor :tenant_name
      attr_accessor :auth_url

      # create a new Keystone client instance with the given credentials
      def initialize(username: '', password: '', tenant_name: '', auth_url: '')
        username.empty?    ? raise("Must provide a username")    : self.username    = username
        password.empty?    ? raise("Must provide a password")    : self.password    = password
        tenant_name.empty? ? raise("Must provide a tenant_name") : self.tenant_name = tenant_name
        auth_url.empty?    ? raise("Must provide an auth_url")   : self.auth_url    = auth_url
      end
    end
  end
end
