# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  # In combination with the <i>Disposition</i> type, the <i>Result</i> type
  # provides the results of an IDV check. A <i>Dispositioned</i> result of
  # <i>FINAL PASS</i> represents a passing check, whereas a <i>TRANSIENT
  # FAIL</i> is still being processed but has failed at least one phase of the
  # check. Until the disposition is <i>FINAL</i>, a result has not been
  # determined.
  class IdentityVerificationResultType < BaseModel
    SKIP = Object.new
    private_constant :SKIP

    # In combination with the <i>Disposition</i> type, the <i>Result</i> type
    # provides the results of an IDV check. A <i>Dispositioned</i> result of
    # <i>FINAL PASS</i> represents a passing check, whereas a <i>TRANSIENT
    # FAIL</i> is still being processed but has failed at least one phase of the
    # check. Until the disposition is <i>FINAL</i>, a result has not been
    # determined.
    # @return [IdentityVerificationResultTypesEnum]
    attr_accessor :idv_result

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['idv_result'] = 'idvResult'
      @_hash
    end

    # An array for optional fields
    def optionals
      %w[
        idv_result
      ]
    end

    # An array for nullable fields
    def nullables
      []
    end

    def initialize(idv_result = nil)
      @idv_result = idv_result unless idv_result == SKIP
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      idv_result = hash.key?('idvResult') ? hash['idvResult'] : SKIP

      # Create object from extracted values.
      IdentityVerificationResultType.new(idv_result)
    end
  end
end