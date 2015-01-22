require "spec_helper"
require "keystone/v2_0/manager/role"

describe "Keystone V2.0 role manager" do
  let(:auth_url)    { "http://some.host:35357/v2.0/" }
  let(:role_client) { Keystone::V2_0::Manager::Role.new(auth_url) }

  it "returns an instance when initialized with a URL" do
    expect(role_client).to be_instance_of(Keystone::V2_0::Manager::Role)
  end

  it "sets the url_endpoint on create" do
    expect(role_client.url_endpoint).to be_truthy
  end
end
