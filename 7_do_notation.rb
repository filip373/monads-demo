require 'dry/monads/try'
require 'dry/monads/result'
require 'dry/monads/do'
M = Dry::Monads

print 'Input: '
input = gets.chomp
input = nil if input == ''

class AddFiveAndDouble
  include Dry::Monads::Try::Mixin
  include Dry::Monads::Result::Mixin
  include Dry::Monads::Do.for(:call)

  def call(value)
    parsed = yield parse(value)
    added = yield add(parsed)
    multiplied = yield multiply(added)

    Success(multiplied)
  end

  private

  def parse(value)
    Try() { Integer(value) }
  end

  def add(value)
    Success(value + 5)
  end

  def multiply(value)
    Success(value * 2)
  end
end

result = AddFiveAndDouble.new.call(input)
puts "Result: #{result}"
