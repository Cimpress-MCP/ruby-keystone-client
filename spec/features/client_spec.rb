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

    it "dynamically creates manager methods for each query type" do
      expect(client).to respond_to(:user_interface)
      expect(client).to respond_to(:role_interface)
      expect(client).to respond_to(:tenant_interface)
      expect(client).to respond_to(:service_interface)
      expect(client).to respond_to(:endpoint_interface)
    end

    it "returns an Array of query results when the query type is invoked" do
      data = "{ \"users\": [
                       { \"username\": \"admin\",
                         \"name\":     \"admin\",
                         \"enabled\":  true,
                         \"email\":    null,
                         \"id\":       \"49f544c6b0d0403b97d90fe0ee0b585f\" }
                     ]
                   }"
      FakeWeb.register_uri(:get, "#{auth_url}/users", :status => [ 200 ], :body => data)
      expect(client.user_interface.list).to be_instance_of(Array)
    end

    it "retuns an exception when no token can be retrieved for the query type" do
      FakeWeb.clean_registry
      FakeWeb.register_uri(:post, "#{auth_url}/tokens", :status => [ 404 ], :body => "")
      expect {
        client.user_interface.list
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
