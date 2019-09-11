class Vendor
  attr_reader :name, :inventory

  def initialize(name)
    @name      = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    @inventory[item]
  end

  def stock(item, number)
    @inventory[item] += number
  end
end
