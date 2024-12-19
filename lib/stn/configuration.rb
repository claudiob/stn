module Stn
  # Provides an object to store global configuration settings.
  #
  # This class is typically not used directly, but by calling
  # {Stn::Config#configure Stn.configure}, which creates and updates a single
  # instance of {Stn::Models::Configuration}.
  #
  # @example Set the Security Token for the API client:
  #   Stn.configure do |config|
  #     config.access_token = 'ABCDEFGHIJ1234567890'
  #   end
  #
  # @see Stn::Config for more examples.
  #
  # An alternative way to set global configuration settings is by storing
  # them in the following environment variables:
  #
  # * +STN_APP_KEY+ to store ...
  # * +STN_TENANT_ID+ to store ...
  # * +STN_CLIENT_ID+ to store ...
  # * +STN_CLIENT_SECRET+ to store ...
  #
  # In case both methods are used together,
  # {Stn::Config#configure Stn.configure} takes precedence.
  #
  # @example Set the API credentials
  #   ENV['STN_APP_KEY'] = '...'
  #   ENV['STN_TENANT_ID'] = '...'
  #   ENV['STN_CLIENT_ID'] = '...'
  #   ENV['STN_CLIENT_SECRET'] = '...'
  #

  class Configuration
    # @return [String] the Security Token for the API calls.
    attr_accessor :access_token

    # @return [String] ...
    attr_accessor :app_key

    # @return [String] ...
    attr_accessor :tenant_id

    # @return [String] ...
    attr_accessor :client_id

    # @return [String] ...
    attr_accessor :client_secret

    # @return [Boolean] whether to mock the HTTP calls to ServiceTitan
    attr_accessor :mock

    # Initialize the global configuration settings, using the values of
    # the specified following environment variables by default.
    def initialize
      @app_key = ENV['STN_APP_KEY']
      @tenant_id = ENV['STN_TENANT_ID']
      @client_id = ENV['STN_CLIENT_ID']
      @client_secret = ENV['STN_CLIENT_SECRET']
      @mock = ENV['STN_MOCK'] == '1'
    end
  end
end
