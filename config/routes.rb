Rails.application.routes.draw do

  resources :bjond_registrations
  get  '/bjond-app/services/' => 'bjondservices#index'
  get  '/bjond-app/services/schema' => 'bjondservices#get_schema'
  post '/bjond-app/services/:groupid/register' => 'bjondservices#register_group_endpoint'
  get  '/bjond-app/services/:groupid/read' => 'bjondservices#get_group_configuration'
end
