# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  # An enum for SDK environments.
  class Environment
    ENVIRONMENT = [
      PRODUCTION = 'production'.freeze
    ].freeze
  end

  # An enum for API servers.
  class Server
    SERVER = [
      DEFAULT = 'default'.freeze,
      ACCESS_TOKEN_SERVER = 'access token server'.freeze
    ].freeze
  end

  # All configuration including auth info and base URI for the API access
  # are configured in this class.
  class Configuration
    # The attribute readers for properties.
    attr_reader :http_client, :connection, :timeout, :max_retries, :retry_interval, :backoff_factor,
                :retry_statuses, :retry_methods, :environment

    class << self
      attr_reader :environments
    end

    def initialize(connection: nil, timeout: 60, max_retries: 0,
                   retry_interval: 1, backoff_factor: 2,
                   retry_statuses: [408, 413, 429, 500, 502, 503, 504, 521, 522, 524, 408, 413, 429, 500, 502, 503, 504, 521, 522, 524],
                   retry_methods: %i[get put get put],
                   environment: Environment::PRODUCTION)
      # The Faraday connection object passed by the SDK user for making requests
      @connection = connection

      # The value to use for connection timeout
      @timeout = timeout

      # The number of times to retry an endpoint call if it fails
      @max_retries = max_retries

      # Pause in seconds between retries
      @retry_interval = retry_interval

      # The amount to multiply each successive retry's interval amount
      # by in order to provide backoff
      @backoff_factor = backoff_factor

      # A list of HTTP statuses to retry
      @retry_statuses = retry_statuses

      # A list of HTTP methods to retry
      @retry_methods = retry_methods

      # Current API environment
      @environment = String(environment)

      # The Http Client to use for making requests.
      @http_client = create_http_client
    end

    def clone_with(connection: nil, timeout: nil, max_retries: nil,
                   retry_interval: nil, backoff_factor: nil,
                   retry_statuses: nil, retry_methods: nil, environment: nil)
      connection ||= self.connection
      timeout ||= self.timeout
      max_retries ||= self.max_retries
      retry_interval ||= self.retry_interval
      backoff_factor ||= self.backoff_factor
      retry_statuses ||= self.retry_statuses
      retry_methods ||= self.retry_methods
      environment ||= self.environment

      Configuration.new(connection: connection, timeout: timeout,
                        max_retries: max_retries,
                        retry_interval: retry_interval,
                        backoff_factor: backoff_factor,
                        retry_statuses: retry_statuses,
                        retry_methods: retry_methods, environment: environment)
    end

    def create_http_client
      FaradayClient.new(timeout: timeout, max_retries: max_retries,
                        retry_interval: retry_interval,
                        backoff_factor: backoff_factor,
                        retry_statuses: retry_statuses,
                        retry_methods: retry_methods, connection: connection)
    end

    # All the environments the SDK can run in.
    ENVIRONMENTS = {
      Environment::PRODUCTION => {
        Server::DEFAULT => 'https://platform.mypayquicker.build/api/v2',
        Server::ACCESS_TOKEN_SERVER => 'https://identity.mypayquicker.build/core/connect'
      }
    }.freeze

    # Generates the appropriate base URI for the environment and the server.
    # @param [Configuration::Server] The server enum for which the base URI is
    # required.
    # @return [String] The base URI.
    def get_base_uri(server = Server::DEFAULT)
      ENVIRONMENTS[environment][server].clone
    end
  end
end
