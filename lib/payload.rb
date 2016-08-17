class Payload
  attr_reader :payload
  def initialize(payload)
    @payload = payload
  end

  def to_json
  <<-eos
    { "type" : "payload",
      "value" : "#{payload}"
    }
  eos
  end
end
