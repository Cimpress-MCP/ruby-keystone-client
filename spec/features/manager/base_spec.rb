require "spec_helper"
require "keystone/v2_0/manager/base"

describe "Keystone V2.0 base manager" do
  let(:url_endpoint) { "/base/endpoint" }
  let(:base_client)  { Keystone::V2_0::Manager::Base.new(url_endpoint) }

  it "returns an instance when initialized with a URL" do
    expect(base_client).to be_instance_of(Keystone::V2_0::Manager::Base)
  end

  it "sets the url_endpoint on create" do
    expect(base_client.url_endpoint).to eq(url_endpoint)
  end
end
