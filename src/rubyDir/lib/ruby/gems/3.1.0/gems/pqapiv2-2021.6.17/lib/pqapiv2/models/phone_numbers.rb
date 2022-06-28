# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  # PhoneNumbers Model.
  class PhoneNumbers < BaseModel
    SKIP = Object.new
    private_constant :SKIP

    # The E.164 formatted primary phone number. This can be the same as the
    # mobile number.
    # @return [String]
    attr_accessor :phone_number

    # The E.164 formatted mobile phone number, required by most financial
    # institutions for account creation, verification, or PSD2 (3DS). Mobile
    # numbers must be unique to a user within a tenant and cannot be shared.
    # @return [String]
    attr_accessor :mobile_number

    # Two-digit country code types
    # @return [CountryTypesEnum]
    attr_accessor :phone_number_country

    # Two-digit country code types
    # @return [CountryTypesEnum]
    attr_accessor :mobile_number_country

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['phone_number'] = 'phoneNumber'
      @_hash['mobile_number'] = 'mobileNumber'
      @_hash['phone_number_country'] = 'phoneNumberCountry'
      @_hash['mobile_number_country'] = 'mobileNumberCountry'
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

    def initialize(phone_number = nil,
                   mobile_number = nil,
                   phone_number_country = nil,
                   mobile_number_country = nil)
      @phone_number = phone_number unless phone_number == SKIP
      @mobile_number = mobile_number unless mobile_number == SKIP
      @phone_number_country = phone_number_country unless phone_number_country == SKIP
      @mobile_number_country = mobile_number_country unless mobile_number_country == SKIP
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      phone_number = hash.key?('phoneNumber') ? hash['phoneNumber'] : SKIP
      mobile_number = hash.key?('mobileNumber') ? hash['mobileNumber'] : SKIP
      phone_number_country =
        hash.key?('phoneNumberCountry') ? hash['phoneNumberCountry'] : SKIP
      mobile_number_country =
        hash.key?('mobileNumberCountry') ? hash['mobileNumberCountry'] : SKIP

      # Create object from extracted values.
      PhoneNumbers.new(phone_number,
                       mobile_number,
                       phone_number_country,
                       mobile_number_country)
    end
  end
end