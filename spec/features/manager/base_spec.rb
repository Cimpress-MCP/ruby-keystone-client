require "spec_helper"
require "keystone/v2_0/manager/base"
require "rest-client"

describe "Keystone V2.0 base manager" do
  let(:host)          { "some.host" }
  let(:url_endpoint)  { "/base/endpoint" }
  let(:json_key)      { "something" }
  let(:priv_port)     { "35357" }
  let(:auth_url)      { "http://#{host}:#{priv_port}/v2.0/" }
  let(:base_client)   { Keystone::V2_0::Manager::Base.new(auth_url, url_endpoint, json_key) }
  let(:endpoint_data) { "{ \"#{json_key}\": [
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
      expect(base_client).to be_instance_of(Keystone::V2_0::Manager::Base)
    end

    it "sets the auth_url on create" do
      expect(base_client.auth_url).to eq(auth_url)
    end

    it "sets the url_endpoint on create" do
      expect(base_client.url_endpoint).to eq(url_endpoint)
    end

    it "sets the json_key on create" do
      expect(base_client.json_key).to eq(json_key)
    end
  end

  describe "list" do
    it "returns JSON content when query is successful" do
      FakeWeb.clean_registry
      FakeWeb.register_uri(:get, "#{auth_url}#{url_endpoint}", :status => [ 200 ], :body => endpoint_data)
      expect(base_client.list).to eq(JSON.parse(endpoint_data))
    end

    it "returns nil when the query is unsuccessful" do
      FakeWeb.clean_registry
      FakeWeb.register_uri(:get, "#{auth_url}#{url_endpoint}", :status => [ 404 ], :body => "")
      expect(base_client.list).to eq(nil)
    end
  end
end
