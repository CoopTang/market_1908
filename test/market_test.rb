require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'
require './lib/market'

class MarketTest < Minitest::Test

  def setup
    @market_name = "South Pearl Street Farmers Market" 
    @vendor_1_name = "Rocky Mountain Fresh"
    @vendor_2_name = "Ba-Nom-a-Nom"
    @vendor_3_name = "Palisade Peach Shack"

    @market = Market.new(@market_name)
    @vendor_1 = Vendor.new(@vendor_1_name)
    @vendor_2 = Vendor.new(@vendor_2_name)  
    @vendor_3 = Vendor.new(@vendor_3_name) 
  end

  def test_it_exists
    assert_instance_of Market, @market
  end

  def test_it_has_attributes
    assert_equal @market_name, @market.name
  end

  def test_it_can_add_vendors
    @market.add_vendor(@vendor_1)
    assert_equal [@vendor_1], @market.vendors

    @market.add_vendor(@vendor_2)
    assert_equal [@vendor_1, @vendor_2], @market.vendors
  end

  def test_can_give_vendor_names
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)
    assert_equal [@vendor_1_name, @vendor_2_name, @vendor_3_name], @market.vendor_names
  end

  def test_can_give_all_vendors_that_sell_an_item
    @vendor_1.stock("Peaches", 35)    
    @vendor_1.stock("Tomatoes", 7)    
    @vendor_2.stock("Banana Nice Cream", 50)    
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)    
    @vendor_3.stock("Peaches", 65)
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)
    assert_equal [@vendor_1, @vendor_3], @market.vendors_that_sell("Peaches")
    assert_equal [@vendor_2], @market.vendors_that_sell("Banana Nice Cream")
  end

  def test_can_list_all_items_sorted
    @vendor_1.stock("Peaches", 35)    
    @vendor_1.stock("Tomatoes", 7)    
    @vendor_2.stock("Banana Nice Cream", 50)    
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)    
    @vendor_3.stock("Peaches", 65)
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)

    expected_array = ["Banana Nice Cream", "Peach-Raspberry Nice Cream", "Peaches", "Tomatoes"].sort
    assert_equal expected_array, @market.sorted_item_list
  end 

  def test_can_get_total_inventory
    @vendor_1.stock("Peaches", 35)    
    @vendor_1.stock("Tomatoes", 7)    
    @vendor_2.stock("Banana Nice Cream", 50)    
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)    
    @vendor_3.stock("Peaches", 65)
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)

    expected_hash = {
      "Peaches" => 100, 
      "Tomatoes" => 7, 
      "Banana Nice Cream" => 50, 
      "Peach-Raspberry Nice Cream" => 25
    }

    assert_equal expected_hash, @market.total_inventory
  end

  def test_can_sell_items_when_stocked
    @vendor_1.stock("Peaches", 35)    
    @vendor_1.stock("Tomatoes", 7)    
    @vendor_2.stock("Banana Nice Cream", 50)    
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)    
    @vendor_3.stock("Peaches", 65)
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)
    assert_equal false, @market.sell("Peaches", 200)
    assert_equal false, @market.sell("Onions", 1)
    assert_equal true, @market.sell("Banana Nice Cream", 5)
    assert_equal 45, @vendor_2.check_stock("Banana Nice Cream")
    assert_equal true, @market.sell("Peaches", 40)
    assert_equal 0, @vendor_1.check_stock("Peaches")
    assert_equal 60, @vendor_3.check_stock("Peaches")
  end

end
