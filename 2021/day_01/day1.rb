def depth(count, inputs)
  return count if inputs.count < 2

  if inputs[0] < inputs[1]
    depth(count+1, inputs[1..])
  else
    depth(count, inputs[1..])
  end
end

def depth_v2(count, inputs)
  return count if inputs.count < 4

  if (inputs[0...3].sum) < (inputs[1...4].sum)
    depth_v2(count+1, inputs[1..])
  else
    depth_v2(count, inputs[1..])
  end
end

RSpec.describe 'Day 1' do
  describe 'part 1' do
    it 'should pass the test case' do
      test_input = [199,200,208,210,200,207,240,269,260,263]
      increasing_depths_count = depth(0, test_input[0..])
      expect(increasing_depths_count).to eq(7)
    end
  end

  describe 'part 2' do
    it 'should pass the test case' do
      test_input = [199,200,208,210,200,207,240,269,260,263]
      increasing_depths_count = depth_v2(0, test_input[0..])
      expect(increasing_depths_count).to eq(5)
    end
  end
end

file = File.open("day1_input.txt")
file_data = file.readlines.map(&:chomp).map(&:to_i)

puts "part 1: #{ depth(0, file_data) }"
puts "part 2: #{ depth_v2(0, file_data) }"
