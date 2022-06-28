# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  # Contains the raw (unprocessed) output from the IDV provider. Format of the
  # raw output can vary widely and is not documented. *For reference/debugging
  # only
  class IdentityVerificationProviderRawOutput < BaseModel
    SKIP = Object.new
    private_constant :SKIP

    # Contains the raw (unprocessed) output from the IDV provider. Format of the
    # raw output can vary widely and is not documented. *For reference/debugging
    # only
    # @return [String]
    attr_accessor :raw

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['raw'] = 'raw'
      @_hash
    end

    # An array for optional fields
    def optionals
      %w[
        raw
      ]
    end

    # An array for nullable fields
    def nullables
      []
    end

    def initialize(raw = nil)
      @raw = raw unless raw == SKIP
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      raw = hash.key?('raw') ? hash['raw'] : SKIP

      # Create object from extracted values.
      IdentityVerificationProviderRawOutput.new(raw)
    end
  end
end