class NormalItem
  def update(item)
    item.sell_in -= 1
    return if item.quality == 0
    item.quality -= 1
    item.quality -= 1 if item.sell_in <= 0
  end
end

class AgedBrie
  def update(item)
    item.sell_in -= 1
    item.quality += 1 if item.quality < 50
    item.quality += 1 if item.sell_in <= 0 && item.quality < 50
  end
end

class Unchanged
  def update(item)
  end
end

class Backstage
  def update(item)
    if item.sell_in <= 0
      item.quality = 0
      item.sell_in -= 1
      return
    end

    item.quality += 1 if item.quality < 50

    if item.sell_in <= 5
      item.quality += 1 if item.quality < 50
      item.quality += 1 if item.quality < 50
    elsif item.sell_in <= 10
      item.quality += 1 if item.quality < 50
    end

    item.sell_in -= 1
  end
end

def update_quality(items)
  items.each do |item|
    klass_for(item.name).update(item)
  end
end

GILDED_ROSE_ITEMS =
  {
    "NORMAL ITEM" => NormalItem.new,
    "Aged Brie" => AgedBrie.new,
    "Backstage passes to a TAFKAL80ETC concert" => Backstage.new
  }

def klass_for(item_name)
  GILDED_ROSE_ITEMS[item_name] || Unchanged.new
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]

