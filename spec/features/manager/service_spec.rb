require "spec_helper"
require "keystone/v2_0/manager/service"

describe "Keystone V2.0 service manager" do
  let(:auth_url)       { "http://some.host:35357/v2.0/" }
  let(:service_client) { Keystone::V2_0::Manager::Service.new(auth_url) }

  it "returns an instance when initialized with a URL" do
    expect(service_client).to be_instance_of(Keystone::V2_0::Manager::Service)
  end

  it "sets the url_endpoint on create" do
    expect(service_client.url_endpoint).to be_truthy
  end
end
