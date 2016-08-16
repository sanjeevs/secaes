require_relative "state_header"
require 'minitest/autorun'
require 'json'

class TestStateHeader < MiniTest::Unit::TestCase
  def setup
    @state_header = StateHeader.new(sn: 0x01234567)
    @json_hash = JSON.parse(@state_header.to_json)
    p @json_hash
  end

  def test_sn
    assert_equal(0x01234567, @state_header.sn)
  end

  def test_json_sn
    assert_equal("0x1234567", @json_hash["sn"])
  end
  
  def test_json_default_spi
    assert_equal("0x0", @json_hash["spi"])
  end
end
