def rotate(char, shift_amount)
  min = 32                # space character
  max = 126               # ~ character
  range = max - min + 1   # 95 total characters

  return char if char < min || char > max

  result = char + shift_amount
  result -= range if result > max
  result += range if result < min

  result
end

def caesar_cipher(string, shift_amount)
  str = string.dup
  (0..str.length - 1).each do |index|
    byte = rotate(str.getbyte(index), shift_amount)
    str.setbyte(index, byte)
  end
  str
end

# cipher usage

message_original = 'This is the orignal secret message!'
message_enc = caesar_cipher(message_original, 7)
message_clear = caesar_cipher(message_enc, -7)
puts message_original
puts message_enc
puts message_clear

# try with printable characters from 32 to 126
puts "\n\n"
char_array = []
(32..126).each do |i|
  char_array << i.chr
end

printable_characters = char_array.join
puts printable_characters
puts "\n\nRotate through all possible...\n\n"

# rotate through all possible positions back to original
(0..95).each do |i|
  puts "#{i}: #{caesar_cipher(printable_characters, i)}"
end
