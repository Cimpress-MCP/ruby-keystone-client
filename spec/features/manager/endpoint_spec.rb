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

  describe "create" do
    let(:service_id)    { "93092u092305920395" }
    let(:region)        { "test" }
    let(:admin_url)     { "/something_else" }
    let(:internal_url)  { "/something" }
    let(:public_url)    { "/something" }
    let(:enabled)       { true }
    let(:endpoint_data) { "{ \"endpoint\":
                            { \"adminurl\":    \"#{admin_url}\",
                              \"service_id\":  \"#{service_id}\",
                              \"region\":      \"#{region}\",
                              \"enabled\":     #{enabled},
                              \"id\":          \"q93h08923hg02h03929350h\",
                              \"internalurl\": \"#{internal_url}\",
                              \"publicurl\":   \"#{public_url}\" }
                          }" }

    describe "when successful" do
      before do
        FakeWeb.clean_registry
        FakeWeb.register_uri(:post, "#{auth_url}#{url_endpoint}", :status => [ 200 ], :body => endpoint_data)
        @endpoint = endpoint_client.create(service_id:   service_id,
                                           region:       region,
                                           admin_url:    admin_url,
                                           internal_url: internal_url,
                                           public_url:   public_url,
                                           enabled:      enabled)
      end

      it "returns a Service instance" do
        expect(@endpoint).to be_instance_of(Keystone::V2_0::Resource::Endpoint)
      end

      it "assigns an ID" do
        expect(@endpoint.id).to be_truthy
      end

      it "assigns the service_id" do
        expect(@endpoint.service_id).to eq(service_id)
      end

      it "assigns the region" do
        expect(@endpoint.region).to eq(region)
      end

      it "assigns the admin_url" do
        expect(@endpoint.admin_url).to eq(admin_url)
      end

      it "assigns the internal_url" do
        expect(@endpoint.internal_url).to eq(internal_url)
      end

      it "assigns the public_url" do
        expect(@endpoint.public_url).to eq(public_url)
      end

      it "assigns enabled" do
        expect(@endpoint.enabled).to eq(enabled)
      end
    end

    it "returns nil when not able to be created" do
      FakeWeb.clean_registry
      FakeWeb.register_uri(:post, "#{auth_url}#{url_endpoint}", :status => [ 404 ], :body => "")
      endpoint = endpoint_client.create(service_id:   service_id,
                                        region:       region,
                                        admin_url:    admin_url,
                                        internal_url: internal_url,
                                        public_url:   public_url,
                                        enabled:      enabled)
      expect(@endpoint).to eq(nil)
    end
  end
end
