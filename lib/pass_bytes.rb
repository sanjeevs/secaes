class PassBytes
  attr_reader :value
  def initialize(len)
    debug_value = "00112233445566778899aabbccddeeff"
    @value = "0x" + debug_value.rjust(len, '0')
  end
  def to_json
    <<-eos
    { "type" : "pass_bytes",
      "value" : "#{value}"
    }
   eos
  end

end

