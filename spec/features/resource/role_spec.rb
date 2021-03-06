require "spec_helper"
require "keystone/v2_0/resource/role"

describe "Keystone V2.0 role resource" do
  let(:name)        { "test" }
  let(:enabled)     { "True" }
  let(:description) { "testing this out" }
  let(:id)          { "930uty09gh209gh" }
  let(:role_data)   { "{ \"enabled\":     \"#{enabled}\",
                         \"description\": \"#{description}\",
                         \"name\":        \"#{name}\",
                         \"id\":          \"#{id}\" }"
                    }

  it "responds with the attribute mappings" do
    expect(Keystone::V2_0::Resource::Role.attr_mappings).to be_truthy
  end

  describe "initialize" do
    let(:resource) { Keystone::V2_0::Resource::Role.new(JSON.parse(role_data)) }

    it "returns a Role resource on initailize" do
      expect(resource).to be_instance_of(Keystone::V2_0::Resource::Role)
    end

    it "assigns the enabled attribute" do
      expect(resource.enabled).to eq(enabled)
    end

    it "assigns the description attribute" do
      expect(resource.description).to eq(description)
    end

    it "assigns the name attribute" do
      expect(resource.name).to eq(name)
    end

    it "assigns the id attribute" do
      expect(resource.id).to eq(id)
    end
  end
end
