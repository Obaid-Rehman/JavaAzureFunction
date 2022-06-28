# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  # Monetary requirements for the transfer
  class MonetaryRequired < BaseModel
    SKIP = Object.new
    private_constant :SKIP

    # Amount of the transfer in the specified currency.
    # @return [Float]
    attr_accessor :amount

    # Currency code type for the object
    # @return [CurrencyTypesEnum]
    attr_accessor :currency

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['amount'] = 'amount'
      @_hash['currency'] = 'currency'
      @_hash
    end

    # An array for optional fields
    def optionals
      []
    end

    # An array for nullable fields
    def nullables
      []
    end

    def initialize(amount = nil,
                   currency = nil)
      @amount = amount unless amount == SKIP
      @currency = currency unless currency == SKIP
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      amount = hash.key?('amount') ? hash['amount'] : SKIP
      currency = hash.key?('currency') ? hash['currency'] : SKIP

      # Create object from extracted values.
      MonetaryRequired.new(amount,
                           currency)
    end
  end
end