def stock_picker (days_prices)
  days_prices2 = days_prices.dup
  days_prices2.shift
  difference = 0
  indexes = Array.new
  days_prices.each_with_index do |price, index|
    days_prices2.each do |price2, index2|
      if price > price2 || (price2 - price) < 0
        next
      elsif (price2 - price) > difference
        difference = price2-price
        indexes[0] = days_prices.find_index(price)
        indexes[1] = days_prices.find_index(price2)
      end
    end
    days_prices2.shift
  end
  print indexes
end

stock_picker([17,3,6,9,15,8,6,1,10])

