# frozen_string_literal: true

# Board Class
class Board
  def initialize
    @a = {}
    @b = {}
    @c = {}

    @board = [@a, @b, @c]
    create
  end
  attr_reader :a, :b, :c, :board

  def show_board
    rows.each do |row|
      row.each do |_, val|
        print (val.nil?) ? ' |' : "#{val}|"
      end
      print "\n"
      # puts "\n"
    end
    nil
  end

  def update_board(location, value)
    case location
    when 'a1'
      a[:x] = value
    when 'a2'
      a[:y] = value
    when 'a3'
      a[:z] = value
    when 'b1'
      b[:x] = value
    when 'b2'
      b[:y] = value
    when 'b3'
      b[:z] = value
    when 'c1'
      c[:x] = value
    when 'c2'
      c[:y] = value
    when 'c3'
      c[:z] = value
    else
      puts 'Invalid Location'
    end
    show_board
  end

  def clean
    rows.each { |key, _| row[key] = nil }
    show_board
  end

  def check
    # Case 1: Horizontal Check
    rows.each do |row|
      return "#{row[:x].upcase} Wins" if row.values.all? { |val| val == row.values[0] && !row.values[0].nil? }
    end

    # Case 2: Vertical check
    col1 = []
    col2 = []
    col3 = []
    columns = [col1, col2, col3]

    rows.each do |row|
      row.each do |key, val|
        col1 << val if key == :x
        col2 << val if key == :y
        col3 << val if key == :z
      end
    end
    # p columns
    columns.each do |col|
      return "#{col[0].upcase} Wins." if col.all? { |str| str == col[0] }
    end

    # Case 3: Angled check
    angle1 = [a[:x], b[:y], c[:z]]
    angle2 = [a[:z], b[:y], c[:x]]
    # p [angle1, angle2].inspect
    if angle1.all?(angle1[0])
      return angle1[0].upcase + ' Wins.'
    elsif angle2.all?(angle2[0])
      return angle2[0].upcase + ' Wins.'
    end

    # nil
  end

  private

  attr_writer :a, :b, :c

  def rows
    board.collect { |row| row }
  end

  def create
    board.each do |row|
      row[:x] = nil
      row[:y] = nil
      row[:z] = nil
    end
  end
end

game = Board.new

puts game.show_board
# puts game.board
puts game.update_board('a1', 'o')
puts game.update_board('a3', 'x')
puts game.update_board('b2', 'x')
puts game.update_board('b1', 'o')
puts game.update_board('c1', 'x')
# puts 'Cleaning Board'
# game.clean
puts game.check
# game.update_board('b3', 'o')
# puts game.check




__END__

# TODO
# create:
#   a board class
#     the board creates 3 hases a, b, c which contain similar keys :x, :y :z
#   a table array that holds the 3 hashes
#   an update method that updates the hashes with the player's selection, 
#     and calls draw method
#   the draw method displays the table in the console
#   a reset method thatg clears the table when a game ends. 
#   a CHECK method that runs on every iteration to see if there's 3 matching pair on the table
#     code:
#       for each key in the hash, check if there's all the same, 
#       else
#         for each key, check the other hashes with the same key, and see if their
#           .. value is the same using a swich case syntax


# NOTE: return the value that returns 3 matches