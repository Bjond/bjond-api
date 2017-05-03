class BjondservicesController < ApplicationController 

  require 'bjond-api'
  require 'syruppay_jose'
  require 'bjond-jwt'
  include BjondJwt

  skip_before_filter :verify_authenticity_token, :only => [:get_schema, :register_group_endpoint, :configure_group_endpoint]

  def index
    @app_info = BjondApi::BjondAppConfig.instance.active_definition
  end

  def edit
    @bjondservice = BjondService.find(params[:id])
  end

  def update
    @bjondservice = BjondService.find(params[:id])
    if @bjondservice.update(bjondservices_params)
      redirect_to @bjondservice.bjond_registration, notice: 'Bjond services was successfully updated.'
    else
      render @bjondservice.bjond_registration
    end
  end

  def register
    registration = BjondRegistration.find_by_id(params[:id])
    if (!registration.nil?)
      response = BjondApi.register_app(BjondApi::BjondAppConfig.instance.active_definition, registration.server)
      if (response.status === 200 )
        render :json => {
          :status => 'Updated'
        }
      else
        raise "Failed to update.\n" + response.body
      end
    else
      render :json => {
        :status => 'Registration not found'
      }
    end
  end



  def register_group_endpoint
    registration = get_registration
    service = BjondService.find_or_initialize_by(:group_id => params[:groupid], :bjond_registration_id => registration.id)
    if (service.endpoint != params[:endpoint])
      service.endpoint = params[:endpoint]
      service.save
    end
    render :json => service
  end

  ################ Encrypted Communication w Bjond servers ################
  def configure_group_endpoint
    puts 'configure_group_endpoint'
    bjond_registration = get_registration
    result = jwt_decode_payload_and_return_json(request.raw_post, bjond_registration)
    BjondApi::BjondAppConfig.instance.configure_group(result, bjond_registration)
    render :json => {
      :status => 'OK'
    }.to_json
  end

  def get_schema
    puts 'get_schema'
    render :json => jwt_encode_payload(BjondApi::BjondAppConfig.instance.group_configuration_schema,
                                       get_registration)
  end

  def get_group_configuration
    # use params[:groupid] to further narrow service request. (Service has group_id, registration does not.)
    bjond_registration = get_registration
    payload = BjondApi::BjondAppConfig.instance.get_group_configuration(bjond_registration)
    render :json => jwt_encode_payload(payload.to_json, bjond_registration)
  end

  def get_registration
    ap params
    registration = nil
    if (params[:environment])
      puts '**************** Looking up registration by environment'
      registration = BjondRegistration.find_by_server(params[:environment])
    end

    if (registration.nil?)
      puts 'searching by remote request'
      registration = BjondRegistration.find_registration_by_remote_request(request)
    end
    ap registration
    return registration
  end

  def get_user_configuration
    bjond_registration = get_registration
    payload = BjondApi::BjondAppConfig.instance.get_user_configuration(bjond_registration)
    render :json => jwt_encode_payload(payload.to_json, bjond_registration)
  end

  def get_user_schema
    puts 'get_user_schema'
    bjond_registration = get_registration
    payload = jwt_encode_payload(BjondApi::BjondAppConfig.instance.user_configuration_schema, bjond_registration)
    render :json => payload
  end

  # Only allow a trusted parameter "white list" through.
  private
    def bjondservices_params
      params.require(:bjond_service).permit(:group_id, :endpoint,)
    end

end