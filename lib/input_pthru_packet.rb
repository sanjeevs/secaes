require_relative "input_cookie"
require_relative "payload"

class InputPthruPacket
  attr_reader :input_cookie, :payload
  def initialize(payload)
    @input_cookie = PthruInputCookie.new
    @payload = Payload.new(payload)
  end
  
  def to_json
    json = "[\n"
    json << input_cookie.to_json(continue: true)
    json << payload.to_json
    json << "]"
    puts json
    json
  end

end

