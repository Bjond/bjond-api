require 'bjond-app-definition'
require 'bjond-consequence'
require 'bjond-event'
require 'bjond-field'
require 'faraday'
require 'bjond-app/engine'
require 'bjond-app-config'

module BjondIntegration
  
  class BjondApi
    def self.register_app(integration_app, bjondhost=ENV['BJOND_SERVER'])

      puts '*********************************'
      puts integration_app.to_json

      conn = Faraday.new(:url => bjondhost)
      return conn.post do |req|
        req.url '/server-core/services/integrationmanager/register?cache=1'
        req.headers['Content-Type'] = 'application/json'
        req.body = integration_app.to_json
      end
    end
  end

end

