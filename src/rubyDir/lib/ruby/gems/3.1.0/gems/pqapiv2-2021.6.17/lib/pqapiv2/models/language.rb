# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  # Preferred language for the user's account. <i>Defaults to English</i>
  class Language < BaseModel
    SKIP = Object.new
    private_constant :SKIP

    # Language type in IETF's BCP 47 format
    # @return [LanguageTypesEnum]
    attr_accessor :language

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['language'] = 'language'
      @_hash
    end

    # An array for optional fields
    def optionals
      %w[
        language
      ]
    end

    # An array for nullable fields
    def nullables
      []
    end

    def initialize(language = nil)
      @language = language unless language == SKIP
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      language = hash.key?('language') ? hash['language'] : SKIP

      # Create object from extracted values.
      Language.new(language)
    end
  end
end