# frozen_string_literal: true

# Assignment
# Implement a method #substrings that takes a word as the first argument and
# then an array of valid substrings (your dictionary) as the second argument.
# It should return a hash listing each substring (case insensitive) that was
# found in the original string and how many times it was found.

#  >    dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
#  =>    ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
#  >    substrings("below", dictionary)
#  =>    { "below" => 1, "low" => 1 }
#
# Next, make sure your method can handle multiple words:
#
#   > substrings("Howdy partner, sit down! How's it going?", dictionary)
#   => { "down" => 1, "how" => 2, "howdy" => 1," go" => 1, "going" => 1, "it" => 2, "i" => 3, "own" => 1, "part" => 1, "partner" => 1, "sit" => 1 }
#
# Quick Tips:
#
#     Recall how to turn strings into arrays and arrays into strings.
#

def substrings(sentence, dictionary)
  string = sentence.downcase
  result = {}
  dictionary.each do |word|
    word_counter = 0
    offset = 0
    while offset = string.index(word,offset)
      offset += 1
      word_counter += 1
    end
    result[word] = word_counter if word_counter > 0
  end
  result
end


######### main

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
p substrings("below", dictionary)
p substrings("Howdy partner, sit down! How's it going?", dictionary)
p substrings("Are you going to sit on it below or are you going to sit on it above.", dictionary)
# => {"below"=>1, "go"=>2, "going"=>2, "it"=>4, "i"=>6, "low"=>1, "sit"=>2}
