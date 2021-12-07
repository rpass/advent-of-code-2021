def school(cohort_sizes, days_of_school)
  return cohort_sizes.sum if days_of_school.zero?

  doubling_cohort = cohort_sizes.shift
  tomorrows_cohort_sizes = cohort_sizes.append(doubling_cohort)
  tomorrows_cohort_sizes[6] += doubling_cohort

  school(tomorrows_cohort_sizes, days_of_school - 1)
end

def parse(input)
  (0..8).map { |i| input.tally[i] || 0 }
end

RSpec.describe 'Day 6' do
  let(:input) {
    [3, 4, 3, 1, 2]
  }
  describe 'Part I' do
    it 'works' do
      expect(school(parse(input), 80)).to eq(5934)
    end
  end

  describe 'Part II' do
    it 'works' do
      expect(school(parse(input), 256)).to eq(26984457539)
    end
  end

  describe 'parse' do
    it 'returns a tally of fish where the index is the number of days left until duplicating' do
      expect(parse(input)).to eq [0, 1, 1, 2, 1, 0, 0, 0, 0]
    end
  end
end

input = File.open('input.txt').read.split(',').map(&:to_i)
puts "Part I: #{school(parse(input), 80)}"
puts "Part II: #{school(parse(input), 256)}"
