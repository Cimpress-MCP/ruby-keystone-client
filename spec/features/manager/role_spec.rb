require "spec_helper"
require "keystone/v2_0/manager/role"

describe "Keystone V2.0 role manager" do
  let(:host)         { "some.host" }
  let(:priv_port)    { "35357" }
  let(:auth_url)     { "http://#{host}:#{priv_port}/v2.0/" }
  let(:role_client)  { Keystone::V2_0::Manager::Role.new(auth_url) }
  let(:url_endpoint) { role_client.url_endpoint }
  let(:role_data)    { "{ \"roles\": [
                            { \"enabled\":     \"True\",
                              \"description\": \"Default role for project membership\",
                              \"name\":        \"_member_\",
                              \"id\":          \"9fe2ff9ee4384b1894a90878d3e92bab\" },
                            { \"id\":          \"e409aeca08b548ceb94ced546e1a4a18\",
                              \"name\":        \"admin\" }
                          ]
                        }"
                     }

  describe "initialize" do
    it "returns an instance when initialized with a URL" do
      expect(role_client).to be_instance_of(Keystone::V2_0::Manager::Role)
    end

    it "sets the url_endpoint on create" do
      expect(role_client.url_endpoint).to be_truthy
    end
  end

  describe "roles" do
    it "returns a list of Role instances on successful query" do
      FakeWeb.clean_registry
      FakeWeb.register_uri(:get, "#{auth_url}#{url_endpoint}", :status => [ 200 ], :body => role_data)
      expect(role_client.roles.map(&:class)).to eq([ Keystone::V2_0::Resource::Role, Keystone::V2_0::Resource::Role ])
    end

    it "returns nil when query is unsuccessful" do
      FakeWeb.clean_registry
      FakeWeb.register_uri(:get, "#{auth_url}#{url_endpoint}", :status => [ 404 ], :body => "")
      expect(role_client.roles).to eq(nil)
    end
  end
end
