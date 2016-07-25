class BjondservicesController < ApplicationController 

  require 'bjond-api'

  def index
    @app_info = BjondIntegration::BjondAppConfig.instance.active_definition
  end

  def register
    BjondIntegration::BjondApi.register_app(BjondIntegration::BjondAppConfig.instance.active_definition)
  end

end