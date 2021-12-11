true_segment_map = [6, 2, 5, 5, 4, 5, 6, 3, 7, 5]
unique_segment_count_map = { 2 => 1, 4 => 4, 3 => 7, 7 => 8 }

def unique_set_lookup(el)
  { 2 => 1, 4 => 4, 3 => 7, 7 => 8 }[el]
end

def identify_unique_set(observed)
  observed.map(&:size).reduce({}) { |out, el| out[el] = unique_set_lookup[el] }
end

TRUE_SEGMENT_MAP = {
  0 => 'abecfg',
  1 => 'cf',
  2 => 'acdeg',
  3 => 'acdfg',
  4 => 'bdcf',
  5 => 'abdfg',
  6 => 'abdefg',
  7 => 'acf',
  8 => 'abcdefg',
  9 => 'abcdfg'
}.freeze

def true_segment_size_map
  TRUE_SEGMENT_MAP.each_with_object({}) { |(k, v), coll| coll[k] = v.size }
end

def analyse_observed_signals(observed)
  (0..9).map do |i|
    observed.filter { |segment_set| segment_set.size == true_segment_size_map[i] }
  end
end

def map_signal_to_segment(potentials)
  # sets = potentials.map { |_k, v| v.map { |inner_v| Set.new(inner_v.split('')) } }

  # {
  #   a: (sets[7].first - sets[1].first).to_a.first
  # }
  potentials
    .filter { |p| p.size == 1 } # select numbers for which we know the signal set
    .each { |sigset| } # find any pair of signal sets where one is a subset of the other except for one signal
end

RSpec.describe 'Day 8' do
  describe 'Part 1' do
    let(:test_input) {
      [
        'be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe',
        'edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc',
        'fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg',
        'fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb',
        'aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea',
        'fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb',
        'dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe',
        'bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef',
        'egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb',
        'gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce'
      ]
    }

    let(:file_input) {
      File.open(File.join(File.dirname(__FILE__),'./input.txt')).readlines()
    }

    it 'counts the number of easy digits in the 4-digit displays' do
      expect(count_easy_digits(test_input)).to eq(26)
    end

    it 'works with the input file data' do
      p count_easy_digits(file_input)
    end
  end
end

def count_easy_digits(observations)
  observations
    .map { |observation| observation.split(' | ') } # split segment sets from display digits
    .map { |_obs, display| display } # extract only display digits
    .map do |digits|
      digits
        .split(' ')
        .map(&:size) # count how many segments are in each displayed digit
        .select { |segment_count| [2, 3, 4, 7].include? segment_count } # filter the counts of displayed segments which match the digits we know have a unique number of segments
        .size # count how many identifiable digits there are in this display
    end.sum # sum up all the counts
end
