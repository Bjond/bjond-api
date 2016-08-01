module BjondJwtHelper
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
    puts "**************************************************"
    puts bjond_registration.encryption_key
    return SyrupPay::JsonEncryptionCompactSerialization.serialization(Base64.decode64(bjond_registration.encryption_key), header, payload)
  end

  def jwt_decode_payload_and_return_json(token, bjond_registration)
    claims_json = SyrupPay::CompactDeserialization.deserialization(Base64.decode64(bjond_registration.encryption_key), token)
    claims = JSON.parse(claims_json)
    return JSON.parse(claims['json'][0])
  end
end
