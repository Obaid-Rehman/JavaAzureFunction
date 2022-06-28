# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  # Account monetary balance
  class Balance < BaseModel
    SKIP = Object.new
    private_constant :SKIP

    # Formatted monetary amount
    # @return [String]
    attr_accessor :formatted_amount

    # Amount of the transfer in the specified currency.
    # @return [Float]
    attr_accessor :amount

    # Currency code type for the object
    # @return [CurrencyTypesEnum]
    attr_accessor :currency

    # Token representing the resource, prefixed with <i>user-</i>, <i>dest-</i>,
    # <i>xfer-</i>, <i>acct-</i>, <i>pmnt-</i>, or <i>docu-</i>.
    # @return [String]
    attr_accessor :token

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['formatted_amount'] = 'formattedAmount'
      @_hash['amount'] = 'amount'
      @_hash['currency'] = 'currency'
      @_hash['token'] = 'token'
      @_hash
    end

    # An array for optional fields
    def optionals
      %w[
        formatted_amount
        token
      ]
    end

    # An array for nullable fields
    def nullables
      []
    end

    def initialize(amount = nil,
                   currency = nil,
                   formatted_amount = nil,
                   token = nil)
      @formatted_amount = formatted_amount unless formatted_amount == SKIP
      @amount = amount unless amount == SKIP
      @currency = currency unless currency == SKIP
      @token = token unless token == SKIP
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      amount = hash.key?('amount') ? hash['amount'] : SKIP
      currency = hash.key?('currency') ? hash['currency'] : SKIP
      formatted_amount =
        hash.key?('formattedAmount') ? hash['formattedAmount'] : SKIP
      token = hash.key?('token') ? hash['token'] : SKIP

      # Create object from extracted values.
      Balance.new(amount,
                  currency,
                  formatted_amount,
                  token)
    end
  end
end
