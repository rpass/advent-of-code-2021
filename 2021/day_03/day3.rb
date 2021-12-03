RSpec.describe 'Day 3' do
  describe 'part 1' do
    it 'finds the answer' do
      test_input = %w[
        00100
        11110
        10110
        10111
        10101
        01111
        00111
        11100
        10000
        11001
        00010
        01010
      ]

      expect(gamma(test_input)).to eq([1, 0, 1, 1, 0])
      expect(epsilon(test_input)).to eq([0, 1, 0, 0, 1])
      expect(power_consumption(test_input)).to eq(198)
    end
  end
end

require 'matrix'
def gamma(input)
  # find most common bit in each position
  counts = input.map { |binary| binary.split('').map(&:to_i) }
                .map { |binary_arr| Vector.elements(binary_arr) }
                .reduce { |memo, binary| memo + Vector.elements(binary) }

  # combine most common bits into binary number
  counts.map { |count| count > input.length / 2 ? 1 : 0 }.to_a
end

def epsilon(input)
  # find complement of gamma
  gamma(input).map { |bit| 1 - bit }
end

def power_consumption(input)
  # convert gamma and epsilon to decimals and multiply
  gamma(input).map(&:to_s).join.to_i(2) * epsilon(input).map(&:to_s).join.to_i(2)
end

actual_input = File.open("input.txt").readlines.map(&:chomp)
puts power_consumption(actual_input)
