require "spec_helper"
require "keystone/v2_0/manager/service"

describe "Keystone V2.0 service manager" do
  let(:host)           { "some.host" }
  let(:priv_port)      { "35357" }
  let(:auth_url)       { "http://#{host}:#{priv_port}/v2.0/" }
  let(:service_client) { Keystone::V2_0::Manager::Service.new(auth_url) }
  let(:url_endpoint)   { service_client.url_endpoint }
  let(:services_data)  { "{ \"OS-KSADM:services\": [
                            { \"id\":          \"876fce0975f841fdbebd8352acda75f4\",
                              \"enabled\":     true,
                              \"type\":        \"identity\",
                              \"name\":        \"keystone\",
                              \"description\": \"Keystone Identity Service\"}
                           ]
                         }"
                       }

  describe "initialize" do
    it "returns an instance when initialized with a URL" do
      expect(service_client).to be_instance_of(Keystone::V2_0::Manager::Service)
    end

    it "sets the url_endpoint on create" do
      expect(service_client.url_endpoint).to be_truthy
    end
  end

  describe "list" do
    it "returns a list of Service instances on successful query" do
      FakeWeb.clean_registry
      FakeWeb.register_uri(:get, "#{auth_url}#{url_endpoint}", :status => [ 200 ], :body => services_data)
      expect(service_client.list.map(&:class)).to eq([ Keystone::V2_0::Resource::Service ])
    end

    it "returns nil when query is unsuccessful" do
      FakeWeb.clean_registry
      FakeWeb.register_uri(:get, "#{auth_url}#{url_endpoint}", :status => [ 404 ], :body => "")
      expect(service_client.list).to eq(nil)
    end
  end

  describe "create" do
    let(:name)         { "test" }
    let(:type)         { "test tool" }
    let(:description)  { "Some kind of test" }
    let(:service_data) { "{ \"OS-KSADM:service\":
                            { \"id\":          \"43dc90f2398b4510acc8f07901e30ed8\",
                              \"enabled\":     true,
                              \"type\":        \"#{type}\",
                              \"name\":        \"#{name}\",
                              \"description\": \"#{description}\" }
                          }" }

    describe "when successful" do
      before do
        FakeWeb.clean_registry
        FakeWeb.register_uri(:post, "#{auth_url}#{url_endpoint}", :status => [ 200 ], :body => service_data)
        @service = service_client.create(name: name, type: type, description: description)
      end

      it "returns a Service instance" do
        expect(@service).to be_instance_of(Keystone::V2_0::Resource::Service)
      end

      it "assigns an ID" do
        expect(@service.id).to be_truthy
      end

      it "assigns the name" do
        expect(@service.name).to eq(name)
      end

      it "assigns the type" do
        expect(@service.type).to eq(type)
      end

      it "assigns the description" do
        expect(@service.description).to eq(description)
      end
    end

    it "returns nil when not able to be created" do
      FakeWeb.clean_registry
      FakeWeb.register_uri(:post, "#{auth_url}#{url_endpoint}", :status => [ 404 ], :body => "")
      service = service_client.create(name: name, type: type, description: description)
      expect(@service).to eq(nil)
    end
  end
end
