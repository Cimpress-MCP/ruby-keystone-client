require "spec_helper"
require "keystone/v2_0/client"

describe "Keystone V2.0 client" do
  let(:username)    { "admin" }
  let(:password)    { "admin" }
  let(:tenant_name) { "admin" }
  let(:auth_url)    { "http://some.host:35357/v2.0/" }
  let(:client)      { Keystone::V2_0::Client.new(username, password, tenant_name, auth_url) }

  it "returns an instance when created with parameters" do
    expect(client).to be_instance_of(Keystone::V2_0::Client)
  end

  it "contains managers for each query type" do
    expect(client.users).to     be_instance_of(Keystone::V2_0::Manager::User)
    expect(client.roles).to     be_instance_of(Keystone::V2_0::Manager::Role)
    expect(client.tenants).to   be_instance_of(Keystone::V2_0::Manager::Tenant)
    expect(client.services).to  be_instance_of(Keystone::V2_0::Manager::Service)
    expect(client.endpoints).to be_instance_of(Keystone::V2_0::Manager::Endpoint)
  end
end
