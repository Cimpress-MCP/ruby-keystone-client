require "spec_helper"
require "keystone/v2_0/client"

describe "Keystone V2.0 client" do
  let(:username)    { "admin" }
  let(:password)    { "admin" }
  let(:tenant_name) { "admin" }
  let(:auth_url)    { "http://some.host:35357/v2.0/" }

  it "returns an instance when created with parameters" do
    expect(Keystone::V2_0::Client.new(username, password, tenant_name, auth_url)).to be_instance_of(Keystone::V2_0::Client)
  end
end
