# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  # Purpose for the payment being made.
  class PaymentPurpose < BaseModel
    SKIP = Object.new
    private_constant :SKIP

    # Used to identify the purpose of a payment and impacts reporting and
    # calculated taxable earnings (if utilizing tax services)
    # @return [PaymentPurposeTypesEnum]
    attr_accessor :purpose

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['purpose'] = 'purpose'
      @_hash
    end

    # An array for optional fields
    def optionals
      %w[
        purpose
      ]
    end

    # An array for nullable fields
    def nullables
      []
    end

    def initialize(purpose = nil)
      @purpose = purpose unless purpose == SKIP
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      purpose = hash.key?('purpose') ? hash['purpose'] : SKIP

      # Create object from extracted values.
      PaymentPurpose.new(purpose)
    end
  end
end
