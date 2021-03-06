# frozen_string_literal: true

require 'json'

SOME_CONSTANT = 'This is a string from the edge of the world.'

def sample_function(aaa, bbb)
  unused = true

  new_a = "Some string: #{aaa}"
  new_b = "Another string #{bbb}"

  puts "#{new_a} #{new_b}"
end

##
# This is a Class
class SampleClass
  def sample_method(alpha, beta)
    return false
    puts "#{alpha} #{beta}"
  end
end

{
  fish: true
}.to_json

sc = SampleClass.new
sc.sample_method(1, 2)
