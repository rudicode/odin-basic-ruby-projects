# Assignment
#
#  Build a method #bubble_sort that takes an array and returns a sorted array.
#  It must use the bubble sort methodology (using #sort would be pretty pointless,
#  wouldn’t it?).
#
# > bubble_sort([4,3,78,2,0,2])
# => [0,2,2,3,4,78]

def bubble_sort(list)
  return nil  if list.length < 1
  return list if list.length == 1

  sorted = list.dup # shallow dup array, leave original intact
  position_max = list.length - 1

  while position_max > 0
    position_min = 0
    while position_min < position_max
      if sorted[position_min] > sorted[position_min+1]
        # swap values
        temp_value = sorted[position_min]
        sorted[position_min] = sorted[position_min+1]
        sorted[position_min+1] = temp_value
      end
      position_min += 1
    end
    position_max -= 1
  end
  sorted
end




########  main  ########

p values = [5,4,3,2,1]
p bubble_sort(values)
puts "\n"

p values = [1,2,3,4,5,6,7,8,9]
p bubble_sort(values)
puts "\n"
p values = [2,7,5,7,3,7,7,8,1,22,0]
p bubble_sort(values)
puts "\n"

p values = Array.new(15) { rand(1..50) }
p bubble_sort(values)
puts "\n"
