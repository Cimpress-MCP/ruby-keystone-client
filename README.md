# Keystone::V2_0::Client

Ruby client to interact with the OpenStack Keystone identity and
service catalog service for Version 2.0 of the API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-keystone-client'
```

And then execute:

```bash
bundle
```

Or install it yourself as:

```bash
gem install ruby-keystone-client
```

## Usage

### Initialization

To interface with a Keystone installation, start by requiring the Keystone library:

```bash
require 'keystone/v2_0/client'

=> true
```

Then, establish a connection to the Keystone service with which you wish to interact. For example, this
Keystone service is installed on localhost running on port 35357, and we are connecting with the following:

- Username: admin
- Password  adminpass
- Tenant:   admin
- Auth URL: http://127.0.0.1:35357/v2.0/

```bash
ks_client = Keystone::V2_0::Client.new("admin", "adminpass", "admin", "http://127.0.0.1:35357/v2.0/")

=> #<Keystone::V2_0::Client:0x000000030715b8 @username="admin", @password="adminpass", @tenant_name="admin", @auth_url="http://127.0.0.1:35357/v2.0/", @user_manager=#<Keystone::V2_0::Manager::User:0x00000003071590 @auth_url="http://127.0.0.1:35357/v2.0/", @url_endpoint="users", @json_key="users">, @role_manager=#<Keystone::V2_0::Manager::Role:0x00000003071568 @auth_url="http://127.0.0.1:35357/v2.0/", @url_endpoint="OS-KSADM/roles", @json_key="roles">, @tenant_manager=#<Keystone::V2_0::Manager::Tenant:0x00000003071540 @auth_url="http://127.0.0.1:35357/v2.0/", @url_endpoint="tenants", @json_key="tenants">, @service_manager=#<Keystone::V2_0::Manager::Service:0x000000030714f0 @auth_url="http://127.0.0.1:35357/v2.0/", @url_endpoint="OS-KSADM/services", @json_key="OS-KSADM:services">, @endpoint_manager=#<Keystone::V2_0::Manager::Endpoint:0x000000030714c8 @auth_url="http://127.0.0.1:35357/v2.0/", @url_endpoint="endpoints", @json_key="endpoints">>
```

Once you have your client "ks", you can continue to query for data within Keystone.

### Tenants

To query for tenants within Keystone:

```bash
ks_client.tenants

=> [#<Keystone::V2_0::Resource::Tenant:0x00000003007398 @description="Admin Tenant", @enabled=true, @id="9958cfb44628476b8f16996e76703292", @name="admin">]
```

### Users

To query for users within Keystone:

```bash
ks_client.users

=> [#<Keystone::V2_0::Resource::User:0x0000000309e518 @username="admin", @name="admin", @enabled=true, @email=nil, @id="49f544c6b0d0403b97d90fe0ee0b585f">]
```

### Roles

To query for roles within Keystone:

```bash
ks_client.roles

=> [#<Keystone::V2_0::Resource::Role:0x0000000303e258 @enabled="True", @description="Default role for project membership", @name="_member_", @id="9fe2ff9ee4384b1894a90878d3e92bab">, #<Keystone::V2_0::Resource::Role:0x0000000303dfd8 @name="admin", @id="e409aeca08b548ceb94ced546e1a4a18">]
```

### Endpoints

To query for endpoints within Keystone:

```bash
ks_client.endpoints

=> [#<Keystone::V2_0::Resource::Endpoint:0x000000032add90 @admin_url="http://127.0.0.1:35357/v2.0", @service_id="876fce0975f841fdbebd8352acda75f4", @region="regionOne", @public_url="http://10.11.13.10:5000/v2.0", @enabled=true, @id="a584ab022f0348ab9335fa2468960578", @internal_url="http://10.11.13.10:5000/v2.0">]
```

### Services

To query for services within Keystone:

```bash
ks_client.services

=> [#<Keystone::V2_0::Resource::Service:0x00000002f9d628 @id="876fce0975f841fdbebd8352acda75f4", @enabled=true, @type="identity", @name="keystone", @description="Keystone Identity Service">]
```
