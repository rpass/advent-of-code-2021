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

    it 'returns position for actual input' do
      data = File.open("input.txt").readlines.map(&:chomp)
      puts position(data)
    end
  end

  describe 'part 2' do
    it 'returns a position depth product of 900' do
      test_input = [
        'forward 5',
        'down 5',
        'forward 8',
        'up 3',
        'down 8',
        'forward 2'
      ]

      expect(position_v2(test_input)).to eq(900)
    end

    it 'returns position for actual input' do
      data = File.open("input.txt").readlines.map(&:chomp)
      puts position_v2(data)
    end
  end
end

def position_v2(input)
  map = input.each_with_object({ aim: 0, depth: 0, position: 0 }) do |instruction, h|
    direction, magnitude = instruction.split(' ')
    magnitude = magnitude.to_i
    case direction
    when 'up'
      h[:aim] -= magnitude
    when 'down'
      h[:aim] += magnitude
    when 'forward'
      h[:depth] += h[:aim] * magnitude
      h[:position] += magnitude
    end
  end

  map[:depth] * map[:position]
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
