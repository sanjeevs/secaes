# Input packet.
# For testing this will always be the clear packet with state header.

class InputClearStatePacket
  attr_reader :input_cookie, :state_header, :pass_bytes, :payload
  def initialize(type, args={})
    if(type == :esp)
      @input_cookie = EspTxInputCookie.new(args)
    end
    else if (type == :ah)
      @input_cookie = AhTxInputCookie.new(args)
    end
    else
      raise ArgumentError, "Did not specify legal value for type.[esp, ah]"
    end
    @state_header = StateHeader.new(args)
    @pass_bytes = PassLen.new(@input_cookie.pass_len)
    @payload = Payload.new(args[:payload])
  end

  def to_json
    json << input_cookie.to_json
    json << state_header.to_json
    json << pass_bytes.to_json
    json << payload.to_json
  end

end

