class BjondservicesController < ApplicationController 

  require 'bjond-api'
  require 'syruppay_jose'

  skip_before_filter :verify_authenticity_token, :only => [:get_schema, :register_group_endpoint, :configure_group_endpoint]

  def index
    @app_info = BjondIntegration::BjondAppConfig.instance.active_definition
  end

  def register
    registration = BjondRegistration.find_by_id(params[:id])
    if (!registration.nil?)
      BjondIntegration::BjondApi.register_app(BjondIntegration::BjondAppConfig.instance.active_definition, registration.server)
      render :json => {
        :status => 'Updated'
      }
    else
      render :json => {
        :status => 'Registration not found'
      }
    end
  end



  def register_group_endpoint
    registration = BjondRegistration.find_registration_by_remote_ip(request.remote_ip)
    service = BjondService.find_or_initialize_by(:group_id => params[:groupid], :registration_id => registration.id)
    if (service.endpoint != params[:endpoint])
      service.endpoint = params[:endpoint]
      service.save
    end
    render :json => service
  end

  ################ Encrypted Communication w Bjond servers ################
  def configure_group_endpoint
    bjond_registration = BjondRegistration.find_registration_by_remote_ip(request.remote_ip)
    result = jwt_decode_payload_and_return_json(request.raw_post, bjond_registration)
    BjondIntegration::BjondAppConfig.instance.configure_group(result, bjond_registration)
    render :json => {
      :status => 'OK'
    }.to_json
  end

  def get_schema
    render :json => jwt_encode_payload(BjondIntegration::BjondAppConfig.instance.group_configuration_schema,
                                       BjondRegistration.find_registration_by_remote_ip(request.remote_ip))
  end

  def get_group_configuration
    bjond_registration = BjondRegistration.find_registration_by_remote_ip(request.remote_ip)
    payload = BjondIntegration::BjondAppConfig.instance.get_group_configuration(bjond_registration)
    render :json => jwt_encode_payload(payload.to_json, BjondRegistration.find_registration_by_remote_ip(request.remote_ip))
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

    def jwt_decode_payload_and_return_json(token, bjond_registration)
      claims_json = SyrupPay::CompactDeserialization.deserialization(Base64.decode64(bjond_registration.encryption_key), token)
      claims = JSON.parse(claims_json)
      return JSON.parse(claims['json'][0])
    end

end