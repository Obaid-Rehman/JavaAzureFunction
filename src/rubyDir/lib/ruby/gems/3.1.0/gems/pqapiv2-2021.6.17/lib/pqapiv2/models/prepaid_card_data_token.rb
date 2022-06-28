# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  # Token assigned to the prepaid card
  class PrepaidCardDataToken < BaseModel
    SKIP = Object.new
    private_constant :SKIP

    # TODO: Write general description for this method
    # @return [String]
    attr_accessor :token

    # Full path of the URI to perform the request action against a prepaid card
    # that replaces the need to build the URL with query params
    # @return [String]
    attr_accessor :url

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['token'] = 'token'
      @_hash['url'] = 'url'
      @_hash
    end

    # An array for optional fields
    def optionals
      %w[
        url
      ]
    end

    # An array for nullable fields
    def nullables
      []
    end

    def initialize(token = nil,
                   url = nil)
      @token = token unless token == SKIP
      @url = url unless url == SKIP
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      token = hash.key?('token') ? hash['token'] : SKIP
      url = hash.key?('url') ? hash['url'] : SKIP

      # Create object from extracted values.
      PrepaidCardDataToken.new(token,
                               url)
    end
  end
end
