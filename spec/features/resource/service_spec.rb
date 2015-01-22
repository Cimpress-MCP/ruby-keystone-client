require "spec_helper"
require "keystone/v2_0/resource/service"

describe "Keystone V2.0 service resource" do
  let(:name)         { "keystone" }
  let(:enabled)      { true }
  let(:type)         { "identity" }
  let(:id)           { "930uty09gh209gh" }
  let(:description)  { "testing this out" }
  let(:service_data) { "{ \"id\":          \"#{id}\",
                          \"enabled\":     #{enabled},
                          \"type\":        \"#{type}\",
                          \"name\":        \"#{name}\",
                          \"description\": \"#{description}\"} "
                     }

  it "responds with the attribute mappings" do
    expect(Keystone::V2_0::Resource::Endpoint.attr_mappings).to be_truthy
  end

  describe "initialize" do
    let(:resource) { Keystone::V2_0::Resource::Service.new(JSON.parse(service_data)) }

    it "returns a Service resource on initailize" do
      expect(resource).to be_instance_of(Keystone::V2_0::Resource::Service)
    end

    it "assigns the id attribute" do
      expect(resource.id).to eq(id)
    end

    it "assigns the enabled attribute" do
      expect(resource.enabled).to eq(enabled)
    end

    it "assigns the type attribute" do
      expect(resource.type).to eq(type)
    end

    it "assigns the name attribute" do
      expect(resource.name).to eq(name)
    end

    it "assigns the description attribute" do
      expect(resource.description).to eq(description)
    end
  end
end
