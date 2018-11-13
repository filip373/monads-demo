require 'dry/monads/task'
require 'thwait'

M = Dry::Monads

print 'Input: '
input = gets.chomp
input = nil if input == ''

class PrefixAndPostfix
  include Dry::Monads::Task::Mixin

  def initialize(value)
    @value = value
  end

  def call
    prefix = Task { generate_prefix }.or { puts 'prefix error' }
    postfix = Task { generate_postfix }.or { puts 'postfix error' }

    prefix.bind { |pre| postfix.fmap { |post| "#{pre} #{@value} #{post}"} }
  end

  private

  def generate_prefix
    sleep 3
    pre = "[#{@value.upcase}]"
    puts 'pre generated'
    pre
  end

  def generate_postfix
    sleep 2
    post = "[#{@value.downcase}]"
    puts 'post generated'
    post
  end
end

task = PrefixAndPostfix.new(input).call

task.fmap do |transformed|
  puts "Transformed value: #{transformed}"
end

puts 'Main thread doing something else...'
sleep 5
puts 'ending'
