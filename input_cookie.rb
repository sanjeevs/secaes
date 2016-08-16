# Input Cookie decoded by the RTL.

# Base Class: For common code.
class InputCookie
  attr_reader :cmd, :has_state, :dir, :tunnel_id,  :pass_len

  def initialize(args={})
    @cmd = 0 
    @dir = 1    # TX
    @has_state = 1
    @replay = 0
    @pass_len = args[:pass_len] || 32
    @tunnel_id = args[:tunnel_id] || 0
    post_initialize(args)
  end


  def cmd_to_s
    return "PASS" if cmd == 0
    return "KAT" if cmd == 1
    return "ESP" if cmd == 2
    return "AH" if cmd == 3
    return "UNDEF"
  end
 
  def dir_to_s
    if dir == 1
      return "TX"
    else
      return "RX"
    end
  end

end

class EspTxInputCookie < InputCookie
  attr_reader :pad_len, :nxt_hdr
  def post_initialize(args)
    @cmd = 2;
    @pad_len = args[:pad_len] || 0
    @nxt_hdr = args[:nxt_hdr]
  end

  def cmd_byte
    cmd << 4 | dir  << 2 | has_state << 1
  end

  def to_json
  <<-eos
    { "type" : "input_cookie",
      "cmd" : "#{cmd_to_s}",
      "dir" : "#{dir_to_s}",
      "has_state" : "#{has_state}",
      "tunnel_id" : "#{"0x" + tunnel_id.to_s(16)}",
      "value" : "#{value}"
    }
  eos
  end

  def value
    "0x" + cmd_byte.to_s(16).rjust(2, '0') + 
         tunnel_id.to_s(16).rjust(8, '0')  +
         pass_len.to_s(16).rjust(2, '0') + 
         pad_len.to_s(16).rjust(2, '0') + 
         nxt_hdr.to_s(16).rjust(2, '0')
  end
end


class AhTxInputCookie < InputCookie
  def post_initialize(args)
    @cmd = 4
    @ah_ipv6 = args[:ah_ipv6]
  end

end

