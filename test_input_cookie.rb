require_relative "input_cookie"
require 'minitest/autorun'
require 'json'

class EspTxInputCookieTest < MiniTest::Unit::TestCase
  def setup
    @esp_tx = EspTxInputCookie.new(nxt_hdr: 0x20,
                              tunnel_id: 0x01234567)
  end
  def test_cmd_byte
    assert_equal(@esp_tx.cmd_byte, 0x26)
  end
  def test_tunnel_id
    assert_equal(0x01234567, @esp_tx.tunnel_id)
  end

  def test_to_json
    json_hash = JSON.parse(@esp_tx.to_json)
    p json_hash
    assert_equal("ESP", json_hash['cmd'])
    assert_equal("TX", json_hash['dir'])
    assert_equal("0x2601234567200020", json_hash["value"])
  end

end
