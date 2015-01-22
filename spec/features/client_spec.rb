require "spec_helper"
require "keystone/v2_0/client"

describe "Keystone V2.0 client" do
  let(:username)    { "admin" }
  let(:password)    { "admin" }
  let(:tenant_name) { "admin" }
  let(:auth_url)    { "http://some.host:35357/v2.0" }
  let(:client)      { Keystone::V2_0::Client.new(username, password, tenant_name, auth_url) }
  let(:token_id)    { "FGGRGBLRHGLISH988GE" }

  before :each do
    FakeWeb.clean_registry
    FakeWeb.register_uri(:post, "#{auth_url}/tokens", :body => "{\"access\":{\"token\":{\"id\":\"#{token_id}\"}}}")
  end

  describe "initialize" do
    it "returns an instance when created with parameters" do
      expect(client).to be_instance_of(Keystone::V2_0::Client)
    end

    it "contains managers for each query type" do
      expect(client.users).to     be_instance_of(Keystone::V2_0::Manager::User)
      expect(client.roles).to     be_instance_of(Keystone::V2_0::Manager::Role)
      expect(client.tenants).to   be_instance_of(Keystone::V2_0::Manager::Tenant)
      expect(client.services).to  be_instance_of(Keystone::V2_0::Manager::Service)
      expect(client.endpoints).to be_instance_of(Keystone::V2_0::Manager::Endpoint)
    end

    it "dynamically creates manager methods for each query type" do
      expect(client).to respond_to(:users)
      expect(client).to respond_to(:roles)
      expect(client).to respond_to(:tenants)
      expect(client).to respond_to(:services)
      expect(client).to respond_to(:endpoints)
    end

    it "retuns an exception when no token can be retrieved for the query type" do
      FakeWeb.clean_registry
      FakeWeb.register_uri(:post, "#{auth_url}/tokens", :status => [ 404 ], :body => "")
      expect {
        client.users
      }.to raise_error
    end
  end

  describe "get_token" do
    it "returns a token for querying" do
      expect(client.send(:get_token)).to eq(token_id)
    end

    it "returns nil when no token can be retrieved" do
      FakeWeb.clean_registry
      FakeWeb.register_uri(:post, "#{auth_url}/tokens", :status => [ 404 ], :body => "")
      expect(client.send(:get_token)).to eq(nil)
    end
  end
end
