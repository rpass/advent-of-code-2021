RSpec.describe 'Day 4' do
  let(:test_boards) do
    [
      [
        [22, 13, 17, 11, 0],
        [8,  2, 23,  4, 24],
        [21, 9, 14, 16, 7],
        [6, 10, 3, 18, 5],
        [1, 12, 20, 15, 19]
      ],
      [
        [3, 15,  0, 2, 22],
        [9, 18, 13, 17, 5],
        [19, 8, 7, 25, 23],
        [20, 11, 10, 24,  4],
        [14, 21, 16, 12,  6]
      ],
      [
        [14, 21, 17, 24,  4],
        [10, 16, 15, 9, 19],
        [18, 8, 23, 26, 20],
        [22, 11, 13, 6, 5],
        [2,  0, 12, 3, 7]
      ]
    ]
  end

  let(:test_sequence) do
    [7, 4, 9, 5, 11, 17, 23, 2, 0, 14, 21, 24, 10, 16, 13, 6, 15, 25, 12, 22, 18, 20, 8, 19, 3, 26, 1]
  end
  describe 'Part I' do
    it 'calculates the winning score' do
      expect(bingo(test_boards, test_sequence)).to eq(4512)
    end
  end
end

require 'set'
def bingo(boards, drawn_sequence)
  # create collection of rows and columns (10 per board), identified by their index (first rows, then columns)
  # for each number in the drawn sequence
  #   remove the number from the each rol
  #   if the rol is empty
  #     use the index of the rol to find the board it belongs to
  #     sum up the remaining numbers in the board
  #     multiply board sum by last drawn number
  rols = boards.flat_map { |board| rols(board) }
  drawn_sequence.each do |drawn_num|
    rols.each { |rol| rol.delete(drawn_num) }
    next unless rols.any?(&:empty?)

    empty_rol_index = rols.index([])
    board_index = empty_rol_index/10

    return boards[board_index].flat_map {|x| x}.sum * drawn_num
  end
end

# create rols (rows and columns) from a board
# [
#   [1,1,1],
#   [2,2,2],
#   [3,3,3]
# ] -> [
#   [1,1,1],
#   [2,2,2],
#   [3,3,3],
#   [1,2,3],
#   [1,2,3],
#   [1,2,3]
# ]
def rols(board)
  [0, 1, 2, 3, 4].each_with_object(board.clone) do |i, memo|
    memo << [board[0][i], board[1][i], board[2][i], board[3][i], board[4][i]]
  end
end

data = File.open("input.txt").read.split("\n\n")
actual_sequence = data[0].split(",").map(&:to_i)
actual_boards = data[1..].map {|b| b.split("\n")}.map {|b| b.map {|row| row.split(" ").map(&:to_i) }}

puts bingo(actual_boards, actual_sequence)
