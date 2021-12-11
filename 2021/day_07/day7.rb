def optimal_fuel(positions)
  average = positions.sum / positions.count
  window = [(average * 0.3).to_i, 5].max

  (average - window..average + window).map do |candidate|
    positions.map do |p|
      if p > candidate
        p - candidate
      else
        candidate - p
      end
    end.sum
  end.min
end

def optimal_fuel_v2(positions)
  average = positions.sum / positions.count
  window = [(average * 0.3).to_i, 5].max

  (average - window..average + window).map do |candidate|
    positions.map do |p|
      if p > candidate
        p - candidate
      else
        candidate - p
      end
    end.map { |dist| (0..dist).sum }.sum
  end.min
end

RSpec.describe 'Day 7' do
  let(:positions) {
    [16,1,2,0,4,2,7,1,2,14]
  }
  describe 'Part I' do
    it 'finds the optimal fuel spend' do
      expect(optimal_fuel(positions)).to eq(37)
    end
  end

  describe 'Part II' do
    it 'finds the optimal fuel spend with linear degradation of efficiency' do
      expect(optimal_fuel_v2(positions)).to eq(168)
    end
  end
end

input = File.open(File.join(File.dirname(__FILE__),'./input.txt')).read.split(',').map(&:to_i)
puts "Part I: #{ optimal_fuel(input) }"
puts "Part II: #{ optimal_fuel_v2(input) }"
