# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

require 'date'
module Pqapiv2
  # Date and time the object will expire
  class Expiration < BaseModel
    SKIP = Object.new
    private_constant :SKIP

    # Quote expiration, ISO-8601 format, UTC by default unless overridden.
    # @return [DateTime]
    attr_accessor :expires

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['expires'] = 'expires'
      @_hash
    end

    # An array for optional fields
    def optionals
      %w[
        expires
      ]
    end

    # An array for nullable fields
    def nullables
      []
    end

    def initialize(expires = nil)
      @expires = expires unless expires == SKIP
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      expires = if hash.key?('expires')
                  (DateTimeHelper.from_rfc3339(hash['expires']) if hash['expires'])
                else
                  SKIP
                end

      # Create object from extracted values.
      Expiration.new(expires)
    end

    def to_expires
      DateTimeHelper.to_rfc3339(expires)
    end
  end
end