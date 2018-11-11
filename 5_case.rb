require 'dry/monads/maybe'
require 'dry/monads/result'
M = Dry::Monads

print 'Input: '
input = gets.chomp
input = nil if input == ''

case M.Some(input.to_i)
  when M.Some(1), M.Some(2) then puts 'first range'
  when M.Some(3..5) then puts 'second range'
  else puts 'something else'
end
