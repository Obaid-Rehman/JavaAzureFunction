# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  # Classifies the format of the required information for a bank account
  class BankAccountRequirement < BaseModel
    SKIP = Object.new
    private_constant :SKIP

    # Two-digit country code types
    # @return [CountryTypesEnum]
    attr_accessor :bank_country

    # Currency code type for the object
    # @return [CurrencyTypesEnum]
    attr_accessor :bank_currency

    # Two-digit country code types
    # @return [CountryTypesEnum]
    attr_accessor :source_country

    # Currency code type for the object
    # @return [CurrencyTypesEnum]
    attr_accessor :source_currency

    # Currency code type for the object
    # @return [List of BankAccountRequiredFields]
    attr_accessor :requirements

    # Object representing monies, including currency, decimal, and formatted
    # amounts
    # @return [MonetaryFormatted]
    attr_accessor :quote

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['bank_country'] = 'bankCountry'
      @_hash['bank_currency'] = 'bankCurrency'
      @_hash['source_country'] = 'sourceCountry'
      @_hash['source_currency'] = 'sourceCurrency'
      @_hash['requirements'] = 'requirements'
      @_hash['quote'] = 'quote'
      @_hash
    end

    # An array for optional fields
    def optionals
      %w[
        source_country
        source_currency
        requirements
        quote
      ]
    end

    # An array for nullable fields
    def nullables
      []
    end

    def initialize(bank_country = nil,
                   bank_currency = nil,
                   source_country = nil,
                   source_currency = nil,
                   requirements = nil,
                   quote = nil)
      @bank_country = bank_country unless bank_country == SKIP
      @bank_currency = bank_currency unless bank_currency == SKIP
      @source_country = source_country unless source_country == SKIP
      @source_currency = source_currency unless source_currency == SKIP
      @requirements = requirements unless requirements == SKIP
      @quote = quote unless quote == SKIP
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      bank_country = hash.key?('bankCountry') ? hash['bankCountry'] : SKIP
      bank_currency = hash.key?('bankCurrency') ? hash['bankCurrency'] : SKIP
      source_country = hash.key?('sourceCountry') ? hash['sourceCountry'] : SKIP
      source_currency =
        hash.key?('sourceCurrency') ? hash['sourceCurrency'] : SKIP
      # Parameter is an array, so we need to iterate through it
      requirements = nil
      unless hash['requirements'].nil?
        requirements = []
        hash['requirements'].each do |structure|
          requirements << (BankAccountRequiredFields.from_hash(structure) if structure)
        end
      end

      requirements = SKIP unless hash.key?('requirements')
      quote = MonetaryFormatted.from_hash(hash['quote']) if hash['quote']

      # Create object from extracted values.
      BankAccountRequirement.new(bank_country,
                                 bank_currency,
                                 source_country,
                                 source_currency,
                                 requirements,
                                 quote)
    end
  end
end
