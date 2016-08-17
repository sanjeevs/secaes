require_relative "../lib/pass_bytes"
require 'minitest/autorun'
require 'json'

class TestPassBytes < MiniTest::Test
  def setup
    @pass_bytes = PassBytes.new(32)
  end

  def test_to_json
    json_hash = JSON.parse(@pass_bytes.to_json)
    assert_equal("pass_bytes", json_hash["type"])
    assert_equal("0x00112233445566778899aabbccddeeff", json_hash["value"])
  end
end

