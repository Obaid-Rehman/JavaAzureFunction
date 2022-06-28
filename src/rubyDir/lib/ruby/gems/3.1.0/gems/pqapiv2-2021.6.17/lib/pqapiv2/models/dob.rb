# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  # Dob Model.
  class Dob < BaseModel
    SKIP = Object.new
    private_constant :SKIP

    # User's date of birth
    # @return [Date]
    attr_accessor :date_of_birth

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['date_of_birth'] = 'dateOfBirth'
      @_hash
    end

    # An array for optional fields
    def optionals
      %w[
        date_of_birth
      ]
    end

    # An array for nullable fields
    def nullables
      []
    end

    def initialize(date_of_birth = nil)
      @date_of_birth = date_of_birth unless date_of_birth == SKIP
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      date_of_birth = hash.key?('dateOfBirth') ? hash['dateOfBirth'] : SKIP

      # Create object from extracted values.
      Dob.new(date_of_birth)
    end
  end
end