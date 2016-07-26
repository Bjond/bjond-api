class BjondRegistration < ActiveRecord::Base
  include BjondIntegration

  attr_encrypted :encryption_key, key: ENV[BjondIntegration::BjondAppConfig.instance.encryption_key_name]

end
