require 'json'
require 'net/http'

require 'stn/error'

module Stn
  # A wrapper around +Net::HTTP+ to send HTTP requests to the ServiceTitan API and
  # return their result or raise an error if the result is unexpected.
  # The basic way to use HTTPRequest is by calling +run+ on an instance.
  # @example List the species of all breeds.
  #   host = ''subdomain.servicetitan.com'
  #   headers = ...
  #   path = '/api/v1/resources/breeds/'
  #   body = {securityToken: security_token}
  #   response = Stn::HTTPRequest.new(path: path, body: body).run
  #   response['Breeds'].map{|breed| breed['species']}
  # @api private
  class Request
    # Initializes an HTTPRequest object.
    # @param [Hash] options the options for the request.
    # @option options [String] :host The host of the request URI.
    # @option options [String] :path The path of the request URI.
    # @option options [Hash] :headers ({}) The HTTP headers for the request.
    # @option options [Hash] :body The body of the request.
    def initialize(options = {})
      @host = options[:host]
      @path = options[:path]
      @body = options[:body]
      @headers = options.fetch :headers, {}
    end

    # Sends the request and returns the body parsed from the JSON response.
    # @return [Hash] the body parsed from the JSON response.
    # @raise [Stn::ConnectionError] if the request fails.
    # @raise [Stn::Error] if parsed body includes errors.
    def run
      return {} if response.body.empty?
      JSON(response.body).tap do |data|
        raise Error, data['error'] if data['error']
      end
    end

  private

    # Run the request and memoize the response or the server error received.
    def response
      @response ||= Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request http_request
      end
      @response
    end

    # @return [URI::HTTPS] the (memoized) URI of the request.
    def uri
      attributes = { host: @host, path: @path }
      @uri ||= URI::HTTPS.build attributes
    end

    # @return [Net::HTTPRequest] the full HTTP request object,
    #   inclusive of headers of request body.
    def http_request
      http_class = if @headers[:'Content-Type'] == 'application/x-www-form-urlencoded'
        Net::HTTP::Post
      else
        Net::HTTP::Get
      end

      @http_request ||= http_class.new(uri.request_uri).tap do |request|
        set_request_body! request
        set_request_headers! request
      end
    end

    # Adds the request headers to the request in the appropriate format.
    # The User-Agent header is also set to recognize the request.
    def set_request_headers!(request)
      request.initialize_http_header @headers
      request.add_field 'User-Agent', 'Stn::HTTPRequest'
    end

    # Adds the request body to the request in the appropriate format.
    def set_request_body!(request)
      if @headers[:'Content-Type'] == 'application/x-www-form-urlencoded'
        request.body = URI.encode_www_form @body
      else
        request.body = @body.to_json if @body
      end
    end
  end
end
