ENV['RACK_ENV'] = 'test'

# URL simulator
require 'fakeweb'

# code coverage calculations
require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

RSpec.configure do |config|
  # config here
end
