require "spec_helper"
require "keystone/v2_0/manager/endpoint"

describe "Keystone V2.0 endpoint manager" do
  let(:host)            { "some.host" }
  let(:priv_port)       { "35357" }
  let(:auth_url)        { "http://#{host}:#{priv_port}/v2.0/" }
  let(:endpoint_client) { Keystone::V2_0::Manager::Endpoint.new(auth_url) }
  let(:url_endpoint)    { endpoint_client.url_endpoint }
  let(:endpoints_data)  { "{ \"endpoints\": [
                              { \"adminurl\":    \"http://#{host}:#{priv_port}/v2.0\",
                                \"service_id\":  \"876fce0975f841fdbebd8352acda75f4\",
                                \"region\":      \"regionOne\",
                                \"publicurl\":   \"http://#{host}:5000/v2.0\",
                                \"enabled\":     true,
                                \"id\":          \"a584ab022f0348ab9335fa2468960578\",
                                \"internalurl\": \"http://#{host}:5000/v2.0\" }
                            ]
                          }"
                        }

  describe "initialize" do
    it "returns an instance when initialized with a URL" do
      expect(endpoint_client).to be_instance_of(Keystone::V2_0::Manager::Endpoint)
    end

    it "sets the url_endpoint on create" do
      expect(endpoint_client.url_endpoint).to be_truthy
    end
  end

  describe "list" do
    it "returns a list of Endpoint instances on successful query" do
      FakeWeb.clean_registry
      FakeWeb.register_uri(:get, "#{auth_url}#{url_endpoint}", :status => [ 200 ], :body => endpoints_data)
      expect(endpoint_client.list.map(&:class)).to eq([ Keystone::V2_0::Resource::Endpoint ])
    end

    it "returns nil when query is unsuccessful" do
      FakeWeb.clean_registry
      FakeWeb.register_uri(:get, "#{auth_url}#{url_endpoint}", :status => [ 404 ], :body => "")
      expect(endpoint_client.list).to eq(nil)
    end
  end
end
