RSpec.describe 'Day 9' do
  let(:test_input) do
    %w[
      2199943210
      3987894921
      9856789892
      8767896789
      9899965678
    ]
  end

  describe 'Part 1' do
    it 'calculates the risk' do
      expect(risk(low_points(test_input))).to eq(15)
    end
  end
end

def low_points(rows)
  low_points = []
  floor_map = rows.map { |row| row.split('').map(&:to_i) } # split input row into columns of ints
  max_y = rows.count - 1
  max_x = rows.first.count - 1

  floor_map.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      lowest_neighbour = if x.zero? && y.zero?
                            [floor_map[y][x + 1], floor_map[y + 1][x]].min
                          elsif x.zero? && y == max_y
                            [floor_map[y - 1][x], floor_map[y][x + 1]].min
                          elsif y.zero? && x == max_x
                            [floor_map[y][x-1], floor_map[y+1][x]].min
                          elsif x == max_x && y == max_y
                            [floor_map[y][x-1], floor_map[y-1][x]].min
                          elsif x
                          end
      low_points << cell if cell < lowest_neighbour
    end
  end
end

def risk(low_points)
  low_points.map { |p| 1 + p }.sum
end
