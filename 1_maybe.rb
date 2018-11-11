require 'dry/monads/maybe'
require 'dry/monads/result'

M = Dry::Monads

print 'Input: '
input = gets.chomp
input = nil if input == ''

# bind
maybe_digits = M.Maybe(input).bind do |i|
  M.Maybe(i.match(/\d/)).bind do |digits|
    M.Maybe(digits.to_s)
  end
end

puts "Digits regexp: #{maybe_digits}"

#fmap
maybe_upcased_reversed = M.Maybe(input)
  .fmap(&:upcase)
  .fmap(&:reverse)

puts "Upcased letters regexp: #{maybe_upcased_reversed}"

#value!
begin
  print 'Calling #value! on digits monad: '
  puts "unwrapped value (#{maybe_digits.value!})"
rescue Dry::Monads::UnwrapError => e
  puts "raised error (#{e})"
end

#value_or
puts "Digits or 0: #{maybe_digits.value_or(0)}"

#or
add_prefix = -> (string) { M.Maybe("prefixed #{string}") }
prefixed_input = M.Maybe(input).bind(add_prefix).or(M.Some('no value to prefix!'))
puts "Prefixed input: #{prefixed_input}"
