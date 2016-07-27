class BjondservicesController < ApplicationController 

  require 'bjond-api'
  require 'syruppay_jose'

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
    render :json => jwt_encode_payload(BjondIntegration::BjondAppConfig.instance.group_configuration_schema,
                                       BjondRegistration.find_registration_by_remote_ip(request.remote_ip))
  end

  def get_group_configuration
    render :json => jwt_encode_payload(BjondIntegration::BjondAppConfig.instance.group_configuration_schema,
                                       BjondRegistration.find_registration_by_remote_ip(request.remote_ip))
  end

  private
    def jwt_encode_payload(json, bjond_registration)
      payload = {
        :json => json,
        :iss => 'Bjönd, Inc.',
        :aud => ENV['BJOND_ADAPTER_AUDIENCE'],
        :exp => Time.now.to_i + 10*3600,
        :nbf => Time.now.to_i - 2*3600,
        :sub => ENV['BJOND_ADAPTER_SUBJECT']
      }.to_json
      header = {:alg => 'A128KW', :enc => 'A128CBC-HS256'}
      return SyrupPay::JsonEncryptionCompactSerialization.serialization(Base64.decode64(bjond_registration.encryption_key), header, payload)
    end

end