# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  # The details of the country's foreign exchange currency.
  class Fx < BaseModel
    SKIP = Object.new
    private_constant :SKIP

    # Currency conversion object details
    # @return [FxObject]
    attr_accessor :fx

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['fx'] = 'fx'
      @_hash
    end

    # An array for optional fields
    def optionals
      %w[
        fx
      ]
    end

    # An array for nullable fields
    def nullables
      []
    end

    def initialize(fx = nil)
      @fx = fx unless fx == SKIP
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      fx = FxObject.from_hash(hash['fx']) if hash['fx']

      # Create object from extracted values.
      Fx.new(fx)
    end
  end
end
