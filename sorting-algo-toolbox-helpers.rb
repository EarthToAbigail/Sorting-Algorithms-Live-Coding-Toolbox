### Helper functions and variables that can be used with the toolbox ###

# Based on minor pentatonic on G
DEFAULT_LIST_BUBBLE = [91, 65, 70, 82, 74, 72, 89, 79, 67, 58, 62, 60, 86, 84, 77, 55]

# Unsorted array based on hirajoshi scale
DEFAULT_LIST_SELECT_INSERT = [82, 81, 70, 62, 57, 74, 86, 55, 67, 75, 79, 63, 58, 69, 87, 91]

# Custom-made list
DEFAULT_LIST_MERGE = [79, 76, 67, 59, 55, 71, 52, 64, 74, 83, 62, 86]

# Uncomment this if you want to add a path to your own samples.
# PATH = ""

# This function allows you to create unsorted lists of values of given length
# based on given ring.
def generate_list(scale:, length: 16, seed: rrand_i(1, 1000000))
  use_random_seed seed
  unsorted_list = []
  while unsorted_list.length < length
    n = scale.choose
    unsorted_list.push(n) unless unsorted_list.include?(n)
  end
  unsorted_list
end

# The default sorted function that will run if no other function is passed
DEFAULT_SORTED = Proc.new { |list, sort_name|
  puts "#{sort_name} sorted the list!"
  puts list
}
