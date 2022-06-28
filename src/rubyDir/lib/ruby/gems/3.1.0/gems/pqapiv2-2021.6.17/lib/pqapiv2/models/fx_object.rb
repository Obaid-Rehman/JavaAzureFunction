# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  # Currency conversion object details
  class FxObject < BaseModel
    SKIP = Object.new
    private_constant :SKIP

    # Amount transferred to the destination
    # @return [Float]
    attr_accessor :destination_amount

    # Currency code type for the object
    # @return [CurrencyTypesEnum]
    attr_accessor :destination_currency

    # Amount of the transfer in the specified currency.
    # @return [Float]
    attr_accessor :source_amount

    # Currency code type for the object
    # @return [CurrencyTypesEnum]
    attr_accessor :source_currency

    # Exchange rate
    # @return [Float]
    attr_accessor :rate

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['destination_amount'] = 'destinationAmount'
      @_hash['destination_currency'] = 'destinationCurrency'
      @_hash['source_amount'] = 'sourceAmount'
      @_hash['source_currency'] = 'sourceCurrency'
      @_hash['rate'] = 'rate'
      @_hash
    end

    # An array for optional fields
    def optionals
      %w[
        destination_amount
        destination_currency
        source_amount
        source_currency
        rate
      ]
    end

    # An array for nullable fields
    def nullables
      []
    end

    def initialize(destination_amount = nil,
                   destination_currency = nil,
                   source_amount = nil,
                   source_currency = nil,
                   rate = nil)
      @destination_amount = destination_amount unless destination_amount == SKIP
      @destination_currency = destination_currency unless destination_currency == SKIP
      @source_amount = source_amount unless source_amount == SKIP
      @source_currency = source_currency unless source_currency == SKIP
      @rate = rate unless rate == SKIP
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      destination_amount =
        hash.key?('destinationAmount') ? hash['destinationAmount'] : SKIP
      destination_currency =
        hash.key?('destinationCurrency') ? hash['destinationCurrency'] : SKIP
      source_amount = hash.key?('sourceAmount') ? hash['sourceAmount'] : SKIP
      source_currency =
        hash.key?('sourceCurrency') ? hash['sourceCurrency'] : SKIP
      rate = hash.key?('rate') ? hash['rate'] : SKIP

      # Create object from extracted values.
      FxObject.new(destination_amount,
                   destination_currency,
                   source_amount,
                   source_currency,
                   rate)
    end
  end
end
