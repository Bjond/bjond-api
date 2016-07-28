Rails.application.routes.draw do

  resources :bjond_registrations
  get  '/bjond-app/services/' => 'bjondservices#index'
  get  '/bjond-app/services/schema' => 'bjondservices#get_schema'
  get  '/bjond-app/services/register' => 'bjondservices#register'
  post '/bjond-app/services/:groupid/register' => 'bjondservices#register_group_endpoint'
  get  '/bjond-app/services/:groupid/read' => 'bjondservices#get_group_configuration'
  post '/bjond-app/services/:groupid/configure' => 'bjondservices#configure_group_endpoint'
end
