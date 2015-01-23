require "spec_helper"
require "keystone/v2_0/manager/service"

describe "Keystone V2.0 service manager" do
  let(:host)           { "some.host" }
  let(:priv_port)      { "35357" }
  let(:auth_url)       { "http://#{host}:#{priv_port}/v2.0/" }
  let(:service_client) { Keystone::V2_0::Manager::Service.new(auth_url) }
  let(:url_endpoint)   { service_client.url_endpoint }
  let(:service_data)   { "{ \"OS-KSADM:services\": [
                            { \"id\":          \"876fce0975f841fdbebd8352acda75f4\",
                              \"enabled\":     true,
                              \"type\":        \"identity\",
                              \"name\":        \"keystone\",
                              \"description\": \"Keystone Identity Service\"}
                           ]
                         }"
                       }

  describe "initialize" do
    it "returns an instance when initialized with a URL" do
      expect(service_client).to be_instance_of(Keystone::V2_0::Manager::Service)
    end

    it "sets the url_endpoint on create" do
      expect(service_client.url_endpoint).to be_truthy
    end
  end

  describe "services" do
    it "returns a list of Service instances on successful query" do
      FakeWeb.clean_registry
      FakeWeb.register_uri(:get, "#{auth_url}#{url_endpoint}", :status => [ 200 ], :body => service_data)
      expect(service_client.list.map(&:class)).to eq([ Keystone::V2_0::Resource::Service ])
    end

    it "returns nil when query is unsuccessful" do
      FakeWeb.clean_registry
      FakeWeb.register_uri(:get, "#{auth_url}#{url_endpoint}", :status => [ 404 ], :body => "")
      expect(service_client.list).to eq(nil)
    end
  end
end
