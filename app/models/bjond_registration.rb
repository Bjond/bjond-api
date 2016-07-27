class BjondRegistration < ActiveRecord::Base
  include BjondIntegration
  require 'attr_encrypted'
  
  attr_encrypted :encryption_key, key: ENV[BjondIntegration::BjondAppConfig.instance.encryption_key_name]

end
