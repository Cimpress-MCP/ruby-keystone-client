require "spec_helper"
require "keystone/v2_0/resource/endpoint"

describe "Keystone V2.0 endpoint resource" do
  let(:admin_url)     { "http://some.host:35357/v2.0" }
  let(:internal_url)  { "http://some.host:35357/v2.0" }
  let(:public_url)    { "http://some.host:5000/v2.0" }
  let(:id)            { "w09ehg0923ht9" }
  let(:enabled)       { true }
  let(:region)        { "Region1" }
  let(:service_id)    { "930uty09gh209gh" }
  let(:endpoint_data) { "{ \"adminurl\":    \"#{admin_url}\",
                           \"service_id\":  \"#{service_id}\",
                           \"region\":      \"#{region}\",
                           \"publicurl\":   \"#{public_url}\",
                           \"enabled\":     #{enabled},
                           \"id\":          \"#{id}\",
                           \"internalurl\": \"#{internal_url}\" }"
                      }

  it "responds with the attribute mappings" do
    expect(Keystone::V2_0::Resource::Endpoint.attr_mappings).to be_truthy
  end

  describe "initialize" do
    let(:resource) { Keystone::V2_0::Resource::Endpoint.new(JSON.parse(endpoint_data)) }

    it "returns an Endpoint resource on initailize" do
      expect(resource).to be_instance_of(Keystone::V2_0::Resource::Endpoint)
    end

    it "assigns the admin_url attribute" do
      expect(resource.admin_url).to eq(admin_url)
    end

    it "assigns the service_id attribute" do
      expect(resource.service_id).to eq(service_id)
    end

    it "assigns the region attribute" do
      expect(resource.region).to eq(region)
    end

    it "assigns the public_url attribute" do
      expect(resource.public_url).to eq(public_url)
    end

    it "assigns the enabled attribute" do
      expect(resource.enabled).to eq(enabled)
    end

    it "assigns the id attribute" do
      expect(resource.id).to eq(id)
    end

    it "assigns the internal_url attribute" do
      expect(resource.internal_url).to eq(internal_url)
    end
  end
end
