# fizzbuzz.rb
# Ask user how many numbers to count to? Default is 100
# print out numbers in order.
# replace a number divisible by 3 with Fizz
# replace a number divisible by 5 with Buzz
# if a number is divisible by both 3 and 5 then replace with FizzBuzz
# eg.
# 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26 ...etc
#
numbers = 100 # default

print "FizzBuzz how many numbers (1-1000) [100]: "
input = gets.chomp.to_i
# if input
  if input > 0 && input <= 1000
    numbers = input
  end
# end
puts "\n\n"

(0..numbers).each do |number|
  if number % 3 == 0
    print "Fizz"
    print "Buzz" if number % 5 == 0
  else
    if number % 5 == 0
      print "Buzz"
    else
      print "#{number}"
    end
  end
  if number < numbers
    print ", "
    print"\n[#{number+1}-#{number+10}] :" if number % 10 == 0 # every 10 numbers 
  end
end
