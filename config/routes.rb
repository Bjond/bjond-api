Rails.application.routes.draw do

  resources :bjond_registrations

  scope '/bjond-app' do
    get  '/services/' => 'bjondservices#index'
    get  '/services/edit/:id' => 'bjondservices#edit'
    patch  '/services/:id' => 'bjondservices#update'
    get  '/services/schema' => 'bjondservices#get_schema'
    get  '/services/register' => 'bjondservices#register'
    post '/services/:groupid/register' => 'bjondservices#register_group_endpoint'
    get  '/services/:groupid/read' => 'bjondservices#get_group_configuration'
    post '/services/:groupid/configure' => 'bjondservices#configure_group_endpoint'
    get  '/services/:groupid/:userid/read' => 'bjondservices#get_user_configuration'
    get  '/services/schema/user' => 'bjondservices#get_user_schema'
  end
end
