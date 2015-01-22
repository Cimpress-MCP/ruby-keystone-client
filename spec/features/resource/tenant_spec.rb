require "spec_helper"
require "keystone/v2_0/resource/tenant"

describe "Keystone V2.0 tenant resource" do
  let(:name)        { "test" }
  let(:enabled)     { true }
  let(:description) { "testing this out" }
  let(:id)          { "930uty09gh209gh" }
  let(:tenant_data) { "{ \"description\": \"#{description}\",
                         \"enabled\":     #{enabled},
                         \"id\":          \"#{id}\",
                         \"name\":        \"#{name}\" }"
                    }

  it "responds with the attribute mappings" do
    expect(Keystone::V2_0::Resource::Tenant.attr_mappings).to be_truthy
  end

  describe "initialize" do
    let(:resource) { Keystone::V2_0::Resource::Tenant.new(JSON.parse(tenant_data)) }

    it "returns a Tenant resource on initailize" do
      expect(resource).to be_instance_of(Keystone::V2_0::Resource::Tenant)
    end

    it "assigns the description attribute" do
      expect(resource.description).to eq(description)
    end

    it "assigns the enabled attribute" do
      expect(resource.enabled).to eq(enabled)
    end

    it "assigns the id attribute" do
      expect(resource.id).to eq(id)
    end

    it "assigns the name attribute" do
      expect(resource.name).to eq(name)
    end
  end
end
