require 'bjond-app-definition'
require 'bjond-consequence'
require 'bjond-event'
require 'bjond-field'
require 'faraday'
require 'bjond-app/engine'
require 'bjond-app-config'
require 'bjond-jwt'
include BjondJwt

module BjondApi
  
  ##
  # Registers the given integration_app with a bjond-server.
  def self.register_app(integration_app, bjondhost=ENV['BJOND_SERVER'])
    conn = Faraday.new(:url => bjondhost)
    puts integration_app.to_json
    return conn.post do |req|
      req.url '/server-core/services/integrationmanager/register'
      req.headers['Content-Type'] = 'application/json'
      req.body = integration_app.to_json
    end
  end

  ##
  # Fires events to all bjond_registrations
  def fire_event(bjond_registration, payload, event_id)
    puts "Firing event for registration " + bjond_registration.id.
    services = BjondService.where(:bjond_registration_id => bjond_registration.id)
    connections = []
    services.each do |bjond_svc|
      url = bjond_svc.endpoint# + "/#{event_id}"
      puts "Creating connection to " + url
      conn = Faraday.new(:url => url)
      conn.post do |req|
        req.headers['Content-Type'] = 'application/json'
        req.body = BjondJwt::jwt_encode_payload(payload, bjond_registration)
      end
    end
    
    return connections
  end

end

