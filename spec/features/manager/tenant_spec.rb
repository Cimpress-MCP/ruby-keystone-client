require "spec_helper"
require "keystone/v2_0/manager/tenant"

describe "Keystone V2.0 tenant manager" do
  let(:host)          { "some.host" }
  let(:priv_port)     { "35357" }
  let(:auth_url)      { "http://#{host}:#{priv_port}/v2.0/" }
  let(:tenant_client) { Keystone::V2_0::Manager::Tenant.new(auth_url) }
  let(:url_endpoint)  { tenant_client.url_endpoint }
  let(:tenant_data)   { "{ \"tenants\": [
                            { \"description\": \"Admin Tenant\",
                              \"enabled\":     true,
                              \"id\":          \"9958cfb44628476b8f16996e76703292\",
                              \"name\":        \"admin\" }
                           ]
                         }"
                       }

  describe "initialize" do
    it "returns an instance when initialized with a URL" do
      expect(tenant_client).to be_instance_of(Keystone::V2_0::Manager::Tenant)
    end

    it "sets the url_endpoint on create" do
      expect(tenant_client.url_endpoint).to be_truthy
    end
  end

  describe "tenants" do
    it "returns a list of Tenant instances on successful query" do
      FakeWeb.clean_registry
      FakeWeb.register_uri(:get, "#{auth_url}#{url_endpoint}", :status => [ 200 ], :body => tenant_data)
      expect(tenant_client.tenants.map(&:class)).to eq([ Keystone::V2_0::Resource::Tenant ])
    end

    it "returns nil when query is unsuccessful" do
      FakeWeb.clean_registry
      FakeWeb.register_uri(:get, "#{auth_url}#{url_endpoint}", :status => [ 404 ], :body => "")
      expect(tenant_client.tenants).to eq(nil)
    end
  end
end
