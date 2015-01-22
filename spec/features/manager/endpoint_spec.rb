require "spec_helper"
require "keystone/v2_0/manager/endpoint"

describe "Keystone V2.0 endpoint manager" do
  let(:auth_url)        { "http://some.host:35357/v2.0/" }
  let(:endpoint_client) { Keystone::V2_0::Manager::Endpoint.new(auth_url) }

  it "returns an instance when initialized with a URL" do
    expect(endpoint_client).to be_instance_of(Keystone::V2_0::Manager::Endpoint)
  end

  it "sets the url_endpoint on create" do
    expect(endpoint_client.url_endpoint).to be_truthy
  end
end
