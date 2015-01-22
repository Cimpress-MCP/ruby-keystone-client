require "json"

module Keystone
  module V2_0
    module Resource
      class Base
        def initialize(data)
          # dynaically assign attributes based on the
          # mappings provided by the subclass
          data.each do |key, val|
            if self.class.attr_mappings.keys.include?(key)
              self.send("#{self.class.attr_mappings[key]}=", data[key])
            end
          end
        end
      end
    end
  end
end
