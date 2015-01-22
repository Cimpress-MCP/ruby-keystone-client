require "spec_helper"
require "keystone/v2_0/manager/user"

describe "Keystone V2.0 user manager" do
  let(:host)         { "some.host" }
  let(:priv_port)    { "35357" }
  let(:auth_url)     { "http://#{host}:#{priv_port}/v2.0/" }
  let(:user_client)  { Keystone::V2_0::Manager::User.new(auth_url) }
  let(:url_endpoint) { user_client.url_endpoint }
  let(:user_data)    { "{ \"users\": [
                         { \"username\": \"admin\",
                           \"name\":     \"admin\",
                           \"enabled\":  true,
                           \"email\":    null,
                           \"id\":       \"49f544c6b0d0403b97d90fe0ee0b585f\" }
                         ]
                       }"
                     }

  describe "initialize" do
    it "returns an instance when initialized with a URL" do
      expect(user_client).to be_instance_of(Keystone::V2_0::Manager::User)
    end

    it "sets the url_endpoint on create" do
      expect(user_client.url_endpoint).to be_truthy
    end
  end

  describe "users" do
    it "returns users on successful query" do
      FakeWeb.clean_registry
      FakeWeb.register_uri(:get, "#{auth_url}#{url_endpoint}", :status => [ 200 ], :body => user_data)
      expect(user_client.users).to eq(JSON.parse(user_data)["users"])
    end

    it "returns nil when query is unsuccessful" do
      FakeWeb.clean_registry
      FakeWeb.register_uri(:get, "#{auth_url}#{url_endpoint}", :status => [ 404 ], :body => "")
      expect(user_client.users).to eq(nil)
    end
  end
end
