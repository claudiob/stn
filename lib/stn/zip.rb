require 'stn/resource'

module Stn
  # Provides methods to interact with ServiceTitan ZIP codes.
  class Zip < Resource
    attr_reader :zip, :state, :zone_name

    def initialize(zip:, state:, zone_name:)
      @zip = zip
      @state = state # I just need a look up table in this repo
      @zone_name = zone_name
    end

    def self.all
      data = request path: "/dispatch/v2/tenant/#{Stn.configuration.tenant_id}/zones"

      data['data'].filter do |zone|
        zone['active']
      end.flat_map do |zone|
        zone['zips'].map do |zip|
          new zip: zip, zone_name: zone['name'], state: 'XX' # need look up
        end
      end
    end
  end
end
