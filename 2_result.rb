require 'dry/monads/result'
require 'dry/monads/maybe'
M = Dry::Monads

print 'Input: '
input = gets.chomp
input = nil if input == ''

class AddFive
  include M::Result::Mixin

  def initialize(value)
    @value = value
  end

  def call
    int_value = nil
    begin
      int_value = Integer(@value)
    rescue ArgumentError, TypeError
      return Failure('value cannot be converted to integer')
    end
    Success(int_value + 5)
  end
end

added = AddFive.new(input).call
puts "Adding 5 to input: #{added}"

# with bind
multiplied = added.bind { |r| r * 2 }
puts "Multiplying input by 2 with #bind: #{multiplied}"

# with fmap
multiplied_fmap = added.fmap { |r| r * 2 }
puts "Multiplying input by 2 with #fmap: #{multiplied_fmap}"

# with value_or
value_ored = added.value_or(0)
puts "Unwrapped added result or 0: #{value_ored}"

# with value!
begin
  print 'Calling #value! on added result: '
  puts "unwrapped value (#{added.value!})"
rescue Dry::Monads::UnwrapError => e
  puts "raised error (#{e})"
end

# with or
ored = added.or(M.Success(0))
puts "Added result or 0: #{ored}"

# failure
puts "Calling #failure on added result: #{added.failure}"

# to_maybe
puts "Calling #to_maybe on added result: #{added.to_maybe}"

# failure?
puts "Is added result failure? #{added.failure?}"

# success?
puts "Is added result success? #{added.success?}"
