require "spec_helper"
require "keystone/v2_0/manager/user"

describe "Keystone V2.0 user manager" do
  let(:user_client) { Keystone::V2_0::Manager::User.new }

  it "returns an instance when initialized with a URL" do
    expect(user_client).to be_instance_of(Keystone::V2_0::Manager::User)
  end

  it "sets the url_endpoint on create" do
    expect(user_client.url_endpoint).to be_truthy
  end
end
