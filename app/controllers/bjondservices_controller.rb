class BjondservicesController < ApplicationController 

  require 'bjond-api'

  def index
    integration_app = BjondIntegration::BjondAppDefinition.new
    integration_app.author      = 'Bjond, Inc.'
    integration_app.name        = 'my integration app'
    integration_app.description = 'Testing API functionality'
    integration_app.iconURL    = 'https://platform.pokitdok.com/documentation/v4/images/logo.png'
    integration_app.configURL  = request.host + ':' + request.port.to_s + '/pokitdok-app/services/'
    integration_app.rootEndpoint = request.host + ':' + request.port.to_s + '/pokitdok-app/services/'

    BjondIntegration::BjondApi.register_app(integration_app)

    @app_info = integration_app
  end

end