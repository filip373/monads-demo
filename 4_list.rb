require 'dry/monads/list'
M = Dry::Monads

print 'Input: '
input = gets.chomp
input = nil if input == ''

# with bind
add_one = M::List[1, 2, input].bind { |x| [Integer(x) + 1] }
puts "Added one with fmap: #{add_one}"

# with fmap
add_one_fmap = M::List[50, 60, input].fmap { |x| Integer(x) + 1 }
puts "Added one with fmap: #{add_one_fmap}"

# value
puts "Value: #{add_one.value}"

# concatenation
puts "Concatenated maps: #{add_one + add_one_fmap}"

# head
puts "Head: #{add_one.head}"

# tail
puts "Tail: #{add_one.tail}"
