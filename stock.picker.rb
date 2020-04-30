# Assignment
#
# Implement a method #stock_picker that takes in an array of stock prices, one for each hypothetical day. It should return a pair of days representing the best day to buy and the best day to sell. Days start at 0.
#
#   > stock_picker([17,3,6,9,15,8,6,1,10])
#   => [1,4]  # for a profit of $15 - $3 == $12
#
# Quick Tips:
#
#     You need to buy before you can sell
#     Pay attention to edge cases like when the lowest day is the last day or the highest day is the first day.
#

def stock_picker(price_list)
  return nil if price_list.length < 2
  buy_index = 0
  sell_index = buy_index + 1
  profit = price_list[sell_index] - price_list[buy_index] # get first profit amount

  price_list.each_with_index do |amount, index|
    i = index + 1
    while i < price_list.length
      if ( price_list[i] - amount > profit )
        profit = price_list[i] - amount
        sell_index = i
        buy_index  = index
      end
      i += 1
    end
  end

  return [buy_index, sell_index]
end


########  main  ########

p price_list = [17,3,6,9,15,8,6,1,10]
p stock_picker(price_list)          # => [1,4] # buy day 1 for $3 and sell day 4 for $15, highest profit of $12
puts "\n"
p price_list = [10,8,6,4,3,2,1]
p stock_picker(price_list)          # => [3, 4] # profit -1
puts "\n"
p price_list.reverse
p stock_picker(price_list.reverse)  # => [0, 6] # profit 9
puts "\n"
p price_list = [2,3,2,2,2,2,2]
p stock_picker(price_list)          # => [0, 1] # profit 1
puts "\n"
p price_list.reverse
p stock_picker(price_list.reverse)  # => [0, 5] # profit 1
puts "\n"
p price_list = [4,10]
p stock_picker(price_list)          # => [0, 1] # profit 6
puts "\n"
p price_list = [1]
p stock_picker(price_list)          # => nil
puts "\n"
p price_list = [1.12, 1.45, 3.33, 1.01]
p stock_picker(price_list)          # => [0, 2] # profit 2.21

# random list of prices
puts "\n"
p price_list = Array.new(10){ rand(1..20) }
p stock_picker(price_list)
