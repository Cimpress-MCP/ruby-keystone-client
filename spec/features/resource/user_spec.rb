require "spec_helper"
require "keystone/v2_0/resource/user"

describe "Keystone V2.0 user resource" do
  let(:username)  { "test" }
  let(:name)      { "blah" }
  let(:enabled)   { true }
  let(:email)     { "test@test.com" }
  let(:id)        { "930uty09gh209gh" }
  let(:user_data) { "{ \"username\": \"#{username}\",
                       \"name\":     \"#{name}\",
                       \"enabled\":  #{enabled},
                       \"email\":    \"#{email}\",
                       \"id\":       \"#{id}\" }"
                  }

  it "responds with the attribute mappings" do
    expect(Keystone::V2_0::Resource::User.attr_mappings).to be_truthy
  end

  describe "initialize" do
    let(:resource) { Keystone::V2_0::Resource::User.new(JSON.parse(user_data)) }

    it "returns a User resource on initailize" do
      expect(resource).to be_instance_of(Keystone::V2_0::Resource::User)
    end

    it "assigns the username attribute" do
      expect(resource.username).to eq(username)
    end

    it "assigns the name attribute" do
      expect(resource.name).to eq(name)
    end

    it "assigns the enabled attribute" do
      expect(resource.enabled).to eq(enabled)
    end

    it "assigns email attribute" do
      expect(resource.email).to eq(email)
    end

    it "assigns the id attribute" do
      expect(resource.id).to eq(id)
    end
  end
end
