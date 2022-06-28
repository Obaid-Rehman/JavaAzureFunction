# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  # Verification status of the bank account (<i>Verified</i>, <i>Disabled</i>)
  class BankAccountStatus < BaseModel
    SKIP = Object.new
    private_constant :SKIP

    # Current verification status type of the bank account
    # @return [BankAccountStatusTypesEnum]
    attr_accessor :status

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['status'] = 'status'
      @_hash
    end

    # An array for optional fields
    def optionals
      %w[
        status
      ]
    end

    # An array for nullable fields
    def nullables
      []
    end

    def initialize(status = nil)
      @status = status unless status == SKIP
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      status = hash.key?('status') ? hash['status'] : SKIP

      # Create object from extracted values.
      BankAccountStatus.new(status)
    end
  end
end