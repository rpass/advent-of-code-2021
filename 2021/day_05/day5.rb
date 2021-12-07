test_input = [
  '0,9 -> 5,9',
  '8,0 -> 0,8',
  '9,4 -> 3,4',
  '2,2 -> 2,1',
  '7,0 -> 7,4',
  '6,4 -> 2,0',
  '0,9 -> 2,9',
  '3,4 -> 1,4',
  '0,0 -> 8,8',
  '5,5 -> 8,2'
]

# for each line
#   generate the points on that line
#   for each point on line
#     if our point map includes that point already
#       increment the count for that coordinate in our point map
#     else
#       add the coordinate to our point map with a count of 1
# return count of coordinates in our point map that have a count > 1
def count_intersections(input)
  input
    .map { |line| line.split(' -> ').map { |coord| coord.split(',').map(&:to_i) } } # parse input
    .filter { |line| line[0][0] == line[1][0] || line [0][1] == line[1][1] } # work with straight lines
    .flat_map do |line|
    x_start, y_start, x_end, y_end = line.flat_map(&:itself)
    if x_start == x_end # Xs are constant
      a, b = [y_start, y_end].sort
      (a..b).map { |y| [x_start, y] } # return points along the line
    elsif y_start == y_end # Ys are constant
      a, b = [x_start, x_end].sort
      (a..b).map { |x| [x, y_start] } # return points along the line
    end
  end.tally.values.count { |v| v > 1 }
end

def count_intersections_v2(input)
  input
    .map { |line| line.split(' -> ').map { |coord| coord.split(',').map(&:to_i) } } # parse input
    .flat_map do |line|
    x_start, y_start, x_end, y_end = line.flat_map(&:itself)
    if x_start == x_end # Xs are constant
      a, b = [y_start, y_end].sort
      (a..b).map { |y| [x_start, y] } # return points along the line
    elsif y_start == y_end # Ys are constant
      a, b = [x_start, x_end].sort
      (a..b).map { |x| [x, y_start] } # return points along the line
    elsif y_end > y_start && x_end > x_start
      (y_start..y_end).to_a.zip((x_start..x_end).to_a)
    elsif y_end > y_start && x_end < x_start
      (y_start..y_end).to_a.zip((x_end..x_start).to_a.reverse)
    elsif y_end < y_start && x_end > x_start
      (y_end..y_start).to_a.reverse.zip((x_start..x_end).to_a)
    elsif y_end < y_start && x_end < x_start
      (y_end..y_start).to_a.zip((x_end..x_start).to_a)
    end
  end.tally.values.count { |v| v > 1 }
end

RSpec.describe 'Day 5' do
  describe 'Part I' do
    it 'counts the intersections for a collection of lines' do
      expect(count_intersections(test_input)).to eq(5)
    end
  end

  describe 'Part II' do
    it 'counts the intersection for a collection of lines' do
      expect(count_intersections_v2(test_input)).to eq(12)
    end
  end
end

input = File.open('input.txt').readlines
puts "Part I: #{count_intersections(input)}"
puts "Part II: #{count_intersections_v2(input)}"
