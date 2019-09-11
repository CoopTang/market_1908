require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'

class VendorTest < Minitest::Test

  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")
  end

  def test_it_exists
    assert_instance_of Vendor, @vendor
  end

  def test_it_has_attributes
    expected_hash = {}
    assert_equal "Rocky Mountain Fresh", @vendor.name
    assert_equal expected_hash, @vendor.inventory
  end

  def test_can_check_stock_of_an_item_with_no_stock
    assert_equal 0, @vendor.check_stock("Peaches")
  end
  
  def test_can_add_stock
    assert_empty @vendor.inventory
    
    @vendor.stock("Peaches", 30)
    expected_hash = { "Peaches" => 30 }
    assert_equal expected_hash, @vendor.inventory
    
    @vendor.stock("Tomatoes", 12)
    expected_hash = {
      "Peaches" => 30,
      "Tomatoes" => 12
    }
    assert_equal expected_hash, @vendor.inventory
  end
  
  def test_can_return_stock_of_item
    @vendor.stock("Peaches", 30)
    @vendor.stock("Peaches", 25)
    assert_equal 55, @vendor.check_stock("Peaches")
  end
end
