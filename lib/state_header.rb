# State header for the input packet.
class StateHeader
  attr_reader :no_ciph, :icv_size, :auth_only, :key256, :use_esn, :sn , :spi
  attr_reader :salt, :iv, :key
  def initialize(args={})
    @no_ciph = args[:no_ciph] || 0
    @icv_size = args[:icv_size] || 16
    @auth_only = args[:auth_only] || 0
    @key256 = args[:key256] || 1
    @use_esn = args[:use_esn] || 0
    @sn = args[:sn] || 0
    @spi = args[:spi] || 0 
    @salt = args[:salt] || 0 
    @iv = args[:iv] || 0
    @key = args[:key] || 0

    unless [8, 12, 16].include? icv_size
      raise ArgumentError, "Invalid size of icv. Valid values are 8,12,16. Got #{icv_size}"
    end

  end

  def icv_size_enc
    return 0 if icv_size == 16
    return 1 if icv_size == 12
    return 2 if icv_size == 8
    raise ArgumentError, "Invalid valie of icv size"
  end

  def ctrl_byte
    skip_replay = 1
    skip_replay << 6 | no_ciph << 5 | icv_size_enc << 3 | auth_only << 2 | key256 << 1 | use_esn
  end

  def to_json
  <<-eos
    { "type" : "state_header",
      "no_ciph" : #{no_ciph}, 
      "icv_size" : #{icv_size},
      "auth_only" : #{auth_only},
      "key256" : #{key256},
      "use_esn" : #{use_esn},
      "sn" : "#{"0x" + sn.to_s(16)}",
      "spi" : "#{"0x" + spi.to_s(16)}",
      "salt" : "#{"0x" + salt.to_s(16)}",
      "iv" : "#{"0x" + iv.to_s(16)}",
      "key" : "#{"0x" + key.to_s(16)}",
      "value" : "#{value}"
    }
  eos
  end

  def value
   "0x00000000000000" + 
    sn.to_s(16).rjust(16, '0') +
    spi.to_s(16).rjust(8, '0') + 
    ctrl_byte.to_s(16).rjust(8, '0') +
    salt.to_s(16).rjust(8, '0') +
    iv.to_s(16).rjust(16, '0') +
    key.to_s(16).rjust(64, '0')
  end
end
