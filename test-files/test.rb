SOME_CONSTANT = 'This is a string from the edge of the world.'.freeze

def sample_function(aaa, bbb)
  new_a = "Some string: #{aaa}"
  new_b = "Another string #{bbb}"

  unused_variable = 123

  puts "#{new_a} #{new_b}"
end

##
# This is a Class
class SampleClass
  def sample_method(a, b)
    puts "#{a} #{b}"
  end
end
