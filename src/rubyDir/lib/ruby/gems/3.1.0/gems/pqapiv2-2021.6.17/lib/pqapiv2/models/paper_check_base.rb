# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  # PaperCheckBase Model.
  class PaperCheckBase < BaseModel
    SKIP = Object.new
    private_constant :SKIP

    # Transfer type
    # @return [TransferTypesEnum]
    attr_accessor :type

    # Amount of the transfer in the specified currency.
    # @return [Float]
    attr_accessor :amount

    # Currency code type for the object
    # @return [CurrencyTypesEnum]
    attr_accessor :currency

    # First line of the address that specifies street number, street name, and
    # building name
    # @return [String]
    attr_accessor :address_line1

    # Second line of the address that specifies the apartment, suite, or space
    # number (or any other designation not literally part of the physical
    # address)
    # @return [String]
    attr_accessor :address_line2

    # Third line of the address that specifies the international or business
    # addresses that do not fit on addressLine2
    # @return [String]
    attr_accessor :address_line3

    # Fourth line of the address, if any
    # @return [String]
    attr_accessor :address_line4

    # Fifth line of the address, if any
    # @return [String]
    attr_accessor :address_line5

    # City or town of the business address
    # @return [String]
    attr_accessor :city

    # State, province, or territory of the business address
    # @return [String]
    attr_accessor :region

    # Two-digit country code types
    # @return [CountryTypesEnum]
    attr_accessor :country

    # Series of letters, digits, or both, included in a postal address for the
    # purpose of sorting mail
    # @return [String]
    attr_accessor :postal_code

    # House or building number of the business address
    # @return [String]
    attr_accessor :premise_number

    # Classifies the address type (<i>Home</i>, <i>Business</i>, <i>Billing</i>,
    # <i>Shipping</i>)
    # @return [AddressTypesEnum]
    attr_accessor :address_type

    # Account ownership types
    # @return [BankAccountOwnershipTypesEnum]
    attr_accessor :bank_account_ownership_type

    # Shipping method type for a pre-paid card or paper check
    # @return [ShippingMethodTypesEnum]
    attr_accessor :shipping_method

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['type'] = 'type'
      @_hash['amount'] = 'amount'
      @_hash['currency'] = 'currency'
      @_hash['address_line1'] = 'addressLine1'
      @_hash['address_line2'] = 'addressLine2'
      @_hash['address_line3'] = 'addressLine3'
      @_hash['address_line4'] = 'addressLine4'
      @_hash['address_line5'] = 'addressLine5'
      @_hash['city'] = 'city'
      @_hash['region'] = 'region'
      @_hash['country'] = 'country'
      @_hash['postal_code'] = 'postalCode'
      @_hash['premise_number'] = 'premiseNumber'
      @_hash['address_type'] = 'addressType'
      @_hash['bank_account_ownership_type'] = 'bankAccountOwnershipType'
      @_hash['shipping_method'] = 'shippingMethod'
      @_hash
    end

    # An array for optional fields
    def optionals
      %w[
        type
        address_line1
        address_line2
        address_line3
        address_line4
        address_line5
        city
        region
        country
        postal_code
        premise_number
        address_type
        bank_account_ownership_type
        shipping_method
      ]
    end

    # An array for nullable fields
    def nullables
      []
    end

    def initialize(amount = nil,
                   currency = nil,
                   type = nil,
                   address_line1 = nil,
                   address_line2 = nil,
                   address_line3 = nil,
                   address_line4 = nil,
                   address_line5 = nil,
                   city = nil,
                   region = nil,
                   country = nil,
                   postal_code = nil,
                   premise_number = nil,
                   address_type = nil,
                   bank_account_ownership_type = nil,
                   shipping_method = nil)
      @type = type unless type == SKIP
      @amount = amount unless amount == SKIP
      @currency = currency unless currency == SKIP
      @address_line1 = address_line1 unless address_line1 == SKIP
      @address_line2 = address_line2 unless address_line2 == SKIP
      @address_line3 = address_line3 unless address_line3 == SKIP
      @address_line4 = address_line4 unless address_line4 == SKIP
      @address_line5 = address_line5 unless address_line5 == SKIP
      @city = city unless city == SKIP
      @region = region unless region == SKIP
      @country = country unless country == SKIP
      @postal_code = postal_code unless postal_code == SKIP
      @premise_number = premise_number unless premise_number == SKIP
      @address_type = address_type unless address_type == SKIP
      unless bank_account_ownership_type == SKIP
        @bank_account_ownership_type =
          bank_account_ownership_type
      end
      @shipping_method = shipping_method unless shipping_method == SKIP
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      amount = hash.key?('amount') ? hash['amount'] : SKIP
      currency = hash.key?('currency') ? hash['currency'] : SKIP
      type = hash.key?('type') ? hash['type'] : SKIP
      address_line1 = hash.key?('addressLine1') ? hash['addressLine1'] : SKIP
      address_line2 = hash.key?('addressLine2') ? hash['addressLine2'] : SKIP
      address_line3 = hash.key?('addressLine3') ? hash['addressLine3'] : SKIP
      address_line4 = hash.key?('addressLine4') ? hash['addressLine4'] : SKIP
      address_line5 = hash.key?('addressLine5') ? hash['addressLine5'] : SKIP
      city = hash.key?('city') ? hash['city'] : SKIP
      region = hash.key?('region') ? hash['region'] : SKIP
      country = hash.key?('country') ? hash['country'] : SKIP
      postal_code = hash.key?('postalCode') ? hash['postalCode'] : SKIP
      premise_number = hash.key?('premiseNumber') ? hash['premiseNumber'] : SKIP
      address_type = hash.key?('addressType') ? hash['addressType'] : SKIP
      bank_account_ownership_type =
        hash.key?('bankAccountOwnershipType') ? hash['bankAccountOwnershipType'] : SKIP
      shipping_method =
        hash.key?('shippingMethod') ? hash['shippingMethod'] : SKIP

      # Create object from extracted values.
      PaperCheckBase.new(amount,
                         currency,
                         type,
                         address_line1,
                         address_line2,
                         address_line3,
                         address_line4,
                         address_line5,
                         city,
                         region,
                         country,
                         postal_code,
                         premise_number,
                         address_type,
                         bank_account_ownership_type,
                         shipping_method)
    end
  end
end