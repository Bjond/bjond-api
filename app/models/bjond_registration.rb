include BjondApi
require 'attr_encrypted'

class BjondRegistration < ActiveRecord::Base
  has_many :bjond_services
  
  
  attr_encrypted :encryption_key, key: ENV[BjondApi::BjondAppConfig.instance.encryption_key_name]

  def self.find_registration_by_remote_ip(ip)
    ip = Resolv.getaddress(ip)
    result = BjondRegistration.find_by_ip(ip)
    if (!result.nil?)
      return result
    end
    host = Resolv.getname(ip)
    host_result = BjondRegistration.find_by_host(host)
    if (!host_result.nil?)
      return host_result
    end

    return BjondRegistration.first
  end

end
