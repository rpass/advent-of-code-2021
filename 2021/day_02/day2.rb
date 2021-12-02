RSpec.describe 'Day 2' do
  describe 'part 1' do
    it 'returns cumulative position' do
      test_input = [
        'forward 5',
        'down 5',
        'forward 8',
        'up 3',
        'down 8',
        'forward 2'
      ]

      expect(position(test_input)).to eq(150)
    end
  end
end

def position(input)
  map = input.each_with_object({}) do |instruction, h|
    direction, magnitude = instruction.split(' ')
    if h[direction]
      h[direction] += magnitude.to_i
    else
      h[direction] = magnitude.to_i
    end
  end

  map['forward'] * (map['down'] - map['up'])
end
