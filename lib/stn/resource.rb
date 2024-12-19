require 'stn/http_request'

module Stn
  # Provides an abstract class for every ServiceTitan resource.
  class Resource
  private

    def self.request(path:, body: {}, include_auth: true)
      request_params = include_auth ? auth_request_params : token_request_params

      instrument do |data|
        Request.new(request_params.merge path: path, body: body).run
      end
    end

    def self.auth_request_params
      headers = {
        'Authorization': Stn.configuration.access_token,
        'ST-App-Key': Stn.configuration.app_key,
      }

      { headers: headers, host: 'api.servicetitan.io' }
    end

    def self.token_request_params
      headers = { 'Content-Type': 'application/x-www-form-urlencoded' }

      { headers: headers, host: 'auth.servicetitan.io' }
    end

    # Provides instrumentation to ActiveSupport listeners
    def self.instrument(&block)
      data = { class_name: name }
      if defined?(ActiveSupport::Notifications)
        ActiveSupport::Notifications.instrument 'Vng.request', data, &block
      else
        block.call data
      end
    end
  end
end
