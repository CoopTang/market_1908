class Vendor
  attr_reader :name, :inventory

  def initialize(name)
    @name      = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    @inventory[item]
  end

  def stock(item, amount)
    @inventory[item] += amount
  end

  def decrease_stock(item, amount)
    return 0 if amount == 0
    remainder = amount > @inventory[item] ? amount - @inventory[item] : 0
    @inventory[item] = @inventory[item] > amount ? @inventory[item] - amount : 0
    remainder
  end
end
