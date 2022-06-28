# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  # User's employer identifier, generally used for tax purposes.
  class UserEmployerId < BaseModel
    SKIP = Object.new
    private_constant :SKIP

    # User's employer identifier
    # @return [String]
    attr_accessor :employer_id

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['employer_id'] = 'employerId'
      @_hash
    end

    # An array for optional fields
    def optionals
      %w[
        employer_id
      ]
    end

    # An array for nullable fields
    def nullables
      []
    end

    def initialize(employer_id = nil)
      @employer_id = employer_id unless employer_id == SKIP
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      employer_id = hash.key?('employerId') ? hash['employerId'] : SKIP

      # Create object from extracted values.
      UserEmployerId.new(employer_id)
    end
  end
end