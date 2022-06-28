# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  # CountryNationalityInformation Model.
  class CountryNationalityInformation < BaseModel
    SKIP = Object.new
    private_constant :SKIP

    # Two-digit country code types
    # @return [CountryTypesEnum]
    attr_accessor :country_of_birth

    # Two-digit country code types
    # @return [CountryTypesEnum]
    attr_accessor :country_of_nationality

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['country_of_birth'] = 'countryOfBirth'
      @_hash['country_of_nationality'] = 'countryOfNationality'
      @_hash
    end

    # An array for optional fields
    def optionals
      %w[
        country_of_birth
        country_of_nationality
      ]
    end

    # An array for nullable fields
    def nullables
      []
    end

    def initialize(country_of_birth = nil,
                   country_of_nationality = nil)
      @country_of_birth = country_of_birth unless country_of_birth == SKIP
      @country_of_nationality = country_of_nationality unless country_of_nationality == SKIP
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      country_of_birth =
        hash.key?('countryOfBirth') ? hash['countryOfBirth'] : SKIP
      country_of_nationality =
        hash.key?('countryOfNationality') ? hash['countryOfNationality'] : SKIP

      # Create object from extracted values.
      CountryNationalityInformation.new(country_of_birth,
                                        country_of_nationality)
    end
  end
end