include BjondApi
require 'attr_encrypted'

class BjondRegistration < ActiveRecord::Base
  has_many :bjond_services, :dependent => :destroy
  
  
  attr_encrypted :encryption_key, key: ENV[BjondApi::BjondAppConfig.instance.encryption_key_name]

  def self.find_registration_by_remote_request(request)
    ip = Resolv.getaddress(request.ip)
    result = BjondRegistration.find_by_ip(ip)
    if (!result.nil?)
      return result
    end
    host = Resolv.getname(ip)
    host_result = BjondRegistration.find_by_host(host)
    if (!host_result.nil?)
      return host_result
    end

    puts 'Warning! No BjondRegistration found for ip: ' + ip + '. This IP resolves to ' + host. + 'Trying most recent registration. '
    puts 'Incoming request parameters: '
    ap request
    return BjondRegistration.last
  end

end
