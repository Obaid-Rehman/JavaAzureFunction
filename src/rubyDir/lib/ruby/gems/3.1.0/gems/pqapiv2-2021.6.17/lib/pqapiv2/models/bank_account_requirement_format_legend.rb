# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  # Classifies the legend format of the required information for a bank account
  class BankAccountRequirementFormatLegend < BaseModel
    SKIP = Object.new
    private_constant :SKIP

    # TODO: Write general description for this method
    # @return [String]
    attr_accessor :key

    # Localized requirement description for display purposes
    # @return [List of KeyValuePairLanguageTypeString]
    attr_accessor :descriptions

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['key'] = 'key'
      @_hash['descriptions'] = 'descriptions'
      @_hash
    end

    # An array for optional fields
    def optionals
      %w[
        key
        descriptions
      ]
    end

    # An array for nullable fields
    def nullables
      []
    end

    def initialize(key = nil,
                   descriptions = nil)
      @key = key unless key == SKIP
      @descriptions = descriptions unless descriptions == SKIP
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      key = hash.key?('key') ? hash['key'] : SKIP
      # Parameter is an array, so we need to iterate through it
      descriptions = nil
      unless hash['descriptions'].nil?
        descriptions = []
        hash['descriptions'].each do |structure|
          descriptions << (KeyValuePairLanguageTypeString.from_hash(structure) if structure)
        end
      end

      descriptions = SKIP unless hash.key?('descriptions')

      # Create object from extracted values.
      BankAccountRequirementFormatLegend.new(key,
                                             descriptions)
    end
  end
end
