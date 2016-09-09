class BjondRegistrationsController < ApplicationController
  before_action :set_bjond_registration, only: [:show, :edit, :update, :destroy]

  require 'bjond-api'
  require 'uri'

  # GET /bjond_registrations
  def index
    @bjond_registrations = BjondRegistration.all
    @app_info = BjondApi::BjondAppConfig.instance.active_definition
  end

  # GET /bjond_registrations/1
  def show
    @services = BjondService.where(:bjond_registration_id => @bjond_registration.id)
  end

  # GET /bjond_registrations/new
  def new
    @bjond_registration = BjondRegistration.new
  end

  # GET /bjond_registrations/1/edit
  def edit
  end

  # POST /bjond_registrations
  def create
    @bjond_registration = BjondRegistration.find_or_initialize_by(bjond_registration_params)
    uri = URI.parse(@bjond_registration.server)
    @bjond_registration.ip = Resolv.getaddress(uri.host)
    @bjond_registration.host = Resolv.getname(@bjond_registration.ip)
    response = BjondApi.register_app(BjondApi::BjondAppConfig.instance.active_definition, @bjond_registration.server)

    if (response.status == 500) 
      throw "Unable to register with Bjond. \n" + response.body
    end


    if @bjond_registration.save
      redirect_to @bjond_registration, notice: 'Bjond registration was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /bjond_registrations/1
  def update
    if @bjond_registration.update(bjond_registration_params)
      redirect_to @bjond_registration, notice: 'Bjond registration was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /bjond_registrations/1
  def destroy
    @bjond_registration.destroy
    redirect_to bjond_registrations_url, notice: 'Bjond registration was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bjond_registration
      @bjond_registration = BjondRegistration.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bjond_registration_params
      params.require(:bjond_registration).permit(:server, :encryption_key, :ip, :host)
    end
end
