require 'stn/configuration'

# An object-oriented Ruby client for Voonigo.
# @see http://www.rubydoc.info/gems/stn/
module Stn
  # Provides methods to read and write global configuration settings.
  #
  # A typical usage is to set the Security Token for the API calls.
  #
  # @example Set the Security Token for the API client:
  #   Stn.configure do |config|
  #     config.security_token = 'ABCDEFGHIJ1234567890'
  #   end
  #
  module Config
    # Yields the global configuration to the given block.
    #
    # @example
    #   Stn.configure do |config|
    #     config.security_token = 'ABCDEFGHIJ1234567890'
    #   end
    #
    # @yield [Stn::Models::Configuration] The global configuration.
    def configure
      yield configuration if block_given?
    end

    # Returns the global {Stn::Models::Configuration} object.
    #
    # While this method _can_ be used to read and write configuration settings,
    # it is easier to use {Stn::Config#configure} Stn.configure}.
    #
    # @example
    #     Stn.configuration.security_token = 'ABCDEFGHIJ1234567890'
    #
    # @return [Stn::Models::Configuration] The global configuration.
    def configuration
      @configuration ||= Stn::Configuration.new
    end
  end

  # @note Config is the only module auto-loaded in the Stn module,
  #       in order to have a syntax as easy as Stn.configure
  extend Config
end
