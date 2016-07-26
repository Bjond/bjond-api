class BjondservicesController < ApplicationController 

  require 'bjond-api'
  require 'jwt'

  skip_before_filter :verify_authenticity_token, :only => [:get_schema, :register_group_endpoint]

  def index
    @app_info = BjondIntegration::BjondAppConfig.instance.active_definition
    BjondIntegration::BjondApi.register_app(BjondIntegration::BjondAppConfig.instance.active_definition)
  end

  def register
    BjondIntegration::BjondApi.register_app(BjondIntegration::BjondAppConfig.instance.active_definition)
  end






  def register_group_endpoint
    puts '****************************'
    puts params[:groupid]
    puts params[:endpoint]
    puts '****************************'
    render :json => 'OK'
  end


  # Encrypted Communication w Bjond servers
  def get_schema
    render :json => jwt_encode_payload(BjondIntegration::BjondAppConfig.instance.group_configuration_schema)
  end

  def get_group_configuration
    render :json => jwt_encode_payload(BjondIntegration::BjondAppConfig.instance.group_configuration_schema)
  end

  private
    def jwt_encode_payload(json)
      payload = {
        :data => json,
        :issuer => 'Bjönd, Inc.',
        :aud => ENV['BJOND_ADAPTER_AUDIENCE'],
        :exp => Time.now.to_i + 10*3600,
        :nbf => Time.now.to_i - 2*3600,
        :sub => ENV['BJOND_ADAPTER_SUBJECT']
      }
      puts payload
      JWT.encode(payload, 'N/IsBXgRxjzaTfcGpHA92w==', 'HS256')
    end

end