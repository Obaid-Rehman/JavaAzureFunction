# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  # PrepaidCardRequestResponse Model.
  class PrepaidCardRequestResponse < BaseModel
    SKIP = Object.new
    private_constant :SKIP

    # Token representing the resource, prefixed with <i>user-</i>, <i>dest-</i>,
    # <i>xfer-</i>, <i>acct-</i>, <i>pmnt-</i>, or <i>docu-</i>.
    # @return [String]
    attr_accessor :token

    # Current status of the prepaid card
    # @return [StatusEnum]
    attr_accessor :status

    # Current status of the prepaid card
    # @return [List of HaetosParams]
    attr_accessor :links

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['token'] = 'token'
      @_hash['status'] = 'status'
      @_hash['links'] = 'links'
      @_hash
    end

    # An array for optional fields
    def optionals
      %w[
        token
        status
        links
      ]
    end

    # An array for nullable fields
    def nullables
      []
    end

    def initialize(token = nil,
                   status = nil,
                   links = nil)
      @token = token unless token == SKIP
      @status = status unless status == SKIP
      @links = links unless links == SKIP
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      token = hash.key?('token') ? hash['token'] : SKIP
      status = hash.key?('status') ? hash['status'] : SKIP
      # Parameter is an array, so we need to iterate through it
      links = nil
      unless hash['links'].nil?
        links = []
        hash['links'].each do |structure|
          links << (HaetosParams.from_hash(structure) if structure)
        end
      end

      links = SKIP unless hash.key?('links')

      # Create object from extracted values.
      PrepaidCardRequestResponse.new(token,
                                     status,
                                     links)
    end
  end
end