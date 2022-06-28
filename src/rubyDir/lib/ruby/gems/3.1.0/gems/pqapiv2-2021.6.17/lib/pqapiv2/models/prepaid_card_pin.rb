# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  # PrepaidCardPin Model.
  class PrepaidCardPin < BaseModel
    SKIP = Object.new
    private_constant :SKIP

    # Card PIN for ATM and Debit usage
    # @return [String]
    attr_accessor :card_pin

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['card_pin'] = 'cardPin'
      @_hash
    end

    # An array for optional fields
    def optionals
      %w[
        card_pin
      ]
    end

    # An array for nullable fields
    def nullables
      []
    end

    def initialize(card_pin = nil)
      @card_pin = card_pin unless card_pin == SKIP
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      card_pin = hash.key?('cardPin') ? hash['cardPin'] : SKIP

      # Create object from extracted values.
      PrepaidCardPin.new(card_pin)
    end
  end
end