require_relative "../lib/input_pthru_packet"
require 'minitest/autorun'
require 'json'

class TestInputPthruPacket < MiniTest::Test
  def setup
    @pthru_packet = InputPthruPacket.new("0x01234567")
  end

  def test_json
    json_hash = JSON.parse(@pthru_packet.to_json)
    p json_hash
    assert_equal("0x0000000000000000", json_hash["input_cookie"]["value"])
  end

end

