class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors.push(vendor)
  end

  def vendor_names
    @vendors.map(&:name)
  end

  def vendors_that_sell(item)
    @vendors.find_all { |vendor| vendor.inventory[item] > 0 }
  end

  def sorted_item_list
    @vendors
      .collect { |vendor| vendor.inventory.keys }
      .flatten
      .uniq
      .sort
  end

  def total_inventory
    stock = {}
    inventories = @vendors.collect { |vendor| vendor.inventory }
    inventories.each do |inventory|
      stock.merge!(inventory) { |_, old_val, new_val| old_val + new_val }
    end
    stock
  end

  def sell (item, amount)
    vendors_with_item = vendors_that_sell(item)
    total_stock = vendors_with_item.sum { |vendor| vendor.check_stock(item) }
    if total_stock >= amount
      remainder = amount
      vendors_with_item.each do |vendor|
        remainder = vendor.decrease_stock(item, remainder)
      end
      true
    else
      false
    end
  end
    
end