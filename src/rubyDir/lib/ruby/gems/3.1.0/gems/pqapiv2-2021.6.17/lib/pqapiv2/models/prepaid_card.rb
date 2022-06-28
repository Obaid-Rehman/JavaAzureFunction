# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

require 'date'
module Pqapiv2
  # PrepaidCard Model.
  class PrepaidCard < BaseModel
    SKIP = Object.new
    private_constant :SKIP

    # Token representing the resource, prefixed with <i>user-</i>, <i>dest-</i>,
    # <i>xfer-</i>, <i>acct-</i>, <i>pmnt-</i>, or <i>docu-</i>.
    # @return [String]
    attr_accessor :token

    # Current status of the prepaid card
    # @return [StatusEnum]
    attr_accessor :status

    # Time at which the object was created.
    # @return [DateTime]
    attr_accessor :created_on

    # Two-digit country code types
    # @return [CountryTypesEnum]
    attr_accessor :country

    # Currency code type for the object
    # @return [CurrencyTypesEnum]
    attr_accessor :currency

    # Specifies a card is <i>Personalized</i> or <i>Non-personalized</i> (i.e.,
    # issued to Preferred Customer)
    # @return [PrepaidCardPersonalizationTypesEnum]
    attr_accessor :card_personalization

    # Package for the card being displayed (<i>Virtual<,i>) or <i>Produced
    # (physical)</i>
    # @return [String]
    attr_accessor :card_package

    # Major credit card network types
    # @return [CardNetworkTypesEnum]
    attr_accessor :card_network

    # Quote expiration, ISO-8601 format, UTC by default unless overridden.
    # @return [DateTime]
    attr_accessor :expires

    # Masked card number with only the first 6 and last 4 digits visible
    # @return [String]
    attr_accessor :card_number

    # Card Verification Value (CVV) on the credit card or debit card. (3-digit
    # number on VISA®, MasterCard® branded credit and debit cards)
    # @return [String]
    attr_accessor :cvv

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['token'] = 'token'
      @_hash['status'] = 'status'
      @_hash['created_on'] = 'createdOn'
      @_hash['country'] = 'country'
      @_hash['currency'] = 'currency'
      @_hash['card_personalization'] = 'cardPersonalization'
      @_hash['card_package'] = 'cardPackage'
      @_hash['card_network'] = 'cardNetwork'
      @_hash['expires'] = 'expires'
      @_hash['card_number'] = 'cardNumber'
      @_hash['cvv'] = 'cvv'
      @_hash
    end

    # An array for optional fields
    def optionals
      %w[
        token
        status
        created_on
        currency
        card_personalization
        card_package
        card_network
        expires
        card_number
        cvv
      ]
    end

    # An array for nullable fields
    def nullables
      []
    end

    def initialize(country = nil,
                   token = nil,
                   status = nil,
                   created_on = nil,
                   currency = nil,
                   card_personalization = nil,
                   card_package = nil,
                   card_network = nil,
                   expires = nil,
                   card_number = nil,
                   cvv = nil)
      @token = token unless token == SKIP
      @status = status unless status == SKIP
      @created_on = created_on unless created_on == SKIP
      @country = country unless country == SKIP
      @currency = currency unless currency == SKIP
      @card_personalization = card_personalization unless card_personalization == SKIP
      @card_package = card_package unless card_package == SKIP
      @card_network = card_network unless card_network == SKIP
      @expires = expires unless expires == SKIP
      @card_number = card_number unless card_number == SKIP
      @cvv = cvv unless cvv == SKIP
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      country = hash.key?('country') ? hash['country'] : SKIP
      token = hash.key?('token') ? hash['token'] : SKIP
      status = hash.key?('status') ? hash['status'] : SKIP
      created_on = if hash.key?('createdOn')
                     (DateTimeHelper.from_rfc3339(hash['createdOn']) if hash['createdOn'])
                   else
                     SKIP
                   end
      currency = hash.key?('currency') ? hash['currency'] : SKIP
      card_personalization =
        hash.key?('cardPersonalization') ? hash['cardPersonalization'] : SKIP
      card_package = hash.key?('cardPackage') ? hash['cardPackage'] : SKIP
      card_network = hash.key?('cardNetwork') ? hash['cardNetwork'] : SKIP
      expires = if hash.key?('expires')
                  (DateTimeHelper.from_rfc3339(hash['expires']) if hash['expires'])
                else
                  SKIP
                end
      card_number = hash.key?('cardNumber') ? hash['cardNumber'] : SKIP
      cvv = hash.key?('cvv') ? hash['cvv'] : SKIP

      # Create object from extracted values.
      PrepaidCard.new(country,
                      token,
                      status,
                      created_on,
                      currency,
                      card_personalization,
                      card_package,
                      card_network,
                      expires,
                      card_number,
                      cvv)
    end

    def to_created_on
      DateTimeHelper.to_rfc3339(created_on)
    end

    def to_expires
      DateTimeHelper.to_rfc3339(expires)
    end
  end
end