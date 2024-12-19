require 'stn/resource'

module Stn
  # Provides methods to interact with ServiceTitan work security tokens.
  class SecurityToken < Resource
    PATH = '/connect/token'

    attr_reader :access_token

    def initialize(access_token:)
      @access_token = access_token
    end

    def self.create
      body = {
        grant_type: 'client_credentials',
        client_id: Stn.configuration.client_id,
        client_secret: Stn.configuration.client_secret,
      }

      data = request path: PATH, body: body, include_auth: false

      new access_token: data['access_token']
    end
  end
end
