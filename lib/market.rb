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
end