require 'dry/monads/try'
require 'dry/monads/maybe'
require 'dry/monads/result'
M = Dry::Monads

print 'Input: '
input = gets.chomp
input = nil if input == ''

class AddFive
  include M::Try::Mixin

  def initialize(value)
    @value = value
  end

  def call
    Try(ArgumentError, TypeError) { Integer(@value) + 5 }
  end
end

added = AddFive.new(input).call

puts "Result value: #{added.value!}" if added.value?
puts "Exception raised: #{added.exception}" if added.error?

# with bind
multiplied_bind = added.bind { |x| x * 2 }
puts "Multiplied with bind: #{multiplied_bind}"

# with bind
multiplied_fmap = added.fmap { |x| x * 2 }
puts "Multiplied with fmap: #{multiplied_fmap}"

# with to_result
result = added.to_result
puts "Added to result: #{result}"

# with to_maybe
maybe = added.to_maybe
puts "Added to maybe: #{maybe}"
