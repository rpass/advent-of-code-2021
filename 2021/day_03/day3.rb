RSpec.describe 'Day 3' do
  let(:test_input) {
    %w[
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
  }
  describe 'part 1' do
    it 'finds the answer' do
      expect(gamma(test_input)).to eq([1, 0, 1, 1, 0])
      expect(epsilon(test_input)).to eq([0, 1, 0, 0, 1])
      expect(power_consumption(test_input)).to eq(198)
    end
  end

  describe 'part 2' do
    it 'finds the answer' do
      parsed_input = test_input.map { |binary| binary.split('') }
      expect(o2_gen_rating(parsed_input)).to eq(23)
      expect(co2_scrub_rating(test_input)).to eq(10)
      expect(life_support_rating(test_input)).to eq(230)
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
puts "Part 1: #{ power_consumption(actual_input) }"

# part 2

def o2_gen_rating(input, prefix = '')
  return prefix.to_i(2) if input.count == 1 && input.first.empty?

  groups = input.each_with_object([[],[]]) do |bin, memo|
      if bin[0] == '0'
        memo[0] << bin[1..]
      else
        memo[1] << bin[1..]
      end
    end
    if groups[0].count > groups[1].count
      o2_gen_rating(groups[0], prefix + '0')
    else
      o2_gen_rating(groups[1], prefix + '1')
    end
end

# basic case: [1, 0, 1] -> [0] -> '0'
def co2_scrub_rating(input, prefix = '')
  return prefix.to_i(2) if input.empty? || input.first == ''
  return (prefix + input.first).to_i(2) if input.count == 1

  groups = input.each_with_object([[],[]]) do |bin, memo|
      if bin[0] == '0'
        memo[0] << bin[1..]
      else
        memo[1] << bin[1..]
      end
  end
  if groups[0].count <= groups[1].count
    co2_scrub_rating(groups[0], prefix + '0')
  else
    co2_scrub_rating(groups[1], prefix + '1')
  end
end

def life_support_rating(input)
  parsed_input = input.map { |binary| binary.split('') }
  o2_gen_rating(parsed_input) * co2_scrub_rating(input)
end

puts "Part II: #{ life_support_rating(actual_input) }"
