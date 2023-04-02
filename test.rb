puts "test"

puts "=" * 25
def some_method(param_1, &block)
  puts "some_method #{param_1}"
  second_method(param_1) do
    yield block
  end
  puts "some_method end"
end

def second_method(param, &block)
  puts "second_method #{param}"
  yield block
  puts "second_method end"
end

some_method(1) do
  puts "some_method block"
end

puts "=" * 25
