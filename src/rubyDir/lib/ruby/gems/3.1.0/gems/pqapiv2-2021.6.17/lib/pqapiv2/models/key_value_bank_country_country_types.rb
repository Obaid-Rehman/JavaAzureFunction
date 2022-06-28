# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  # KeyValueBankCountryCountryTypes Model.
  class KeyValueBankCountryCountryTypes < BaseModel
    SKIP = Object.new
    private_constant :SKIP

    # TODO: Write general description for this method
    # @return [String]
    attr_accessor :key

    # Two-digit country code types
    # @return [CountryTypesEnum]
    attr_accessor :value

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['key'] = 'key'
      @_hash['value'] = 'value'
      @_hash
    end

    # An array for optional fields
    def optionals
      %w[
        key
        value
      ]
    end

    # An array for nullable fields
    def nullables
      []
    end

    def initialize(key = 'BANK_COUNTRY',
                   value = nil)
      @key = key unless key == SKIP
      @value = value unless value == SKIP
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      key = hash['key'] ||= 'BANK_COUNTRY'
      value = hash.key?('value') ? hash['value'] : SKIP

      # Create object from extracted values.
      KeyValueBankCountryCountryTypes.new(key,
                                          value)
    end
  end
end
