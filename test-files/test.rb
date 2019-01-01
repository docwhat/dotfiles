# frozen_string_literal: true

SOME_CONSTANT = 'This is a string from the edge of the world.'

def sample_function(aaa, bbb)
  new_a = "Some string: #{aaa}"
  new_b = "Another string #{bbb}"

  puts "#{new_a} #{new_b}"
end

##
# This is a Class
class SampleClass
  def sample_method(alpha, beta)
    puts "#{alpha} #{beta}"
  end
end
