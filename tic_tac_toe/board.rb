# frozen_string_literal: true

# Class for the Game's Board
class Board
  def initialize
    @a = {}
    @b = {}
    @c = {}
    @board = [a, b, c]
    create
  end

  def show
    rows.each do |row|
      row.each do |_, val|
        print val.nil? ? ' |' : "#{val}|"
      end
      print "\n"
    end
    nil
  end

  def update(location, value)
    clean if game_won?
    try_again('taken', value) if taken?(location)

    case location
    when '1'
      a[:x] ||= value
    when '2'
      a[:y] ||= value
    when '3'
      a[:z] ||= value
    when '4'
      b[:x] ||= value
    when '5'
      b[:y] ||= value
    when '6'
      b[:z] ||= value
    when '7'
      c[:x] ||= value
    when '8'
      c[:y] ||= value
    when '9'
      c[:z] ||= value
    else
      try_again('invalid', value)
    end
    show
    if full?
      clean unless game_won?
    end
  end

  def check
    if h_check.include?('Wins')
      h_check
    elsif v_check.include?('Wins')
      v_check
    else
      a_check unless a_check.nil?
    end
  end

  private

  attr_accessor :a, :b, :c
  attr_reader :board

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

  def clean
    puts 'Cleaning Board...'
    sleep 1
    rows.each do |row|
      row.each { |key, _| row[key] = nil }
    end
    # show
    puts "Done. \n"
  end

  # Horizontal Check
  def h_check
    rows.each do |row|
      return winner(row[:x]) if row.values.all? { |val| val == row.values[0] && !row.values[0].nil? }
    end
  end

  # Vertical Check
  def v_check
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
    columns.each do |col|
      return winner(col[0]) if col.all? { |str| str == col[0] && !col[0].nil? }
    end
  end

  # Angled Check
  def a_check
    angle1 = [a[:x], b[:y], c[:z]]
    angle2 = [a[:z], b[:y], c[:x]]

    if angle1.all?(angle1[0])
      winner(angle1[0]) unless angle1[0].nil?
    elsif angle2.all?(angle2[0])
      winner(angle2[0]) unless angle2[0].nil?
    end
  end

  def full?
    all_keys = []

    rows.each do |row|
      row.each do |_, val|
        all_keys << val
      end
    end

    all_keys.all? { |val| !val.nil? }
  end

  def game_won?
    check.to_s.include?('Win') ? true : false
  end

  def winner(val)
    'Player ' + val.upcase + ' Wins.' unless val.nil?
  end

  def try_again(type, value)
    case type
    when 'invalid'
      puts 'Invalid Location, Try Again:'
      loc = gets.chomp.downcase
      update(loc, value)
      puts ''
    when 'taken'
      puts 'Location in use, Try Again:'
      loc = gets.chomp.downcase
      update(loc, value)
      puts ''
    end
  end

  def taken?(location)
    loc = case location
          when '1'
            a[:x]
          when '2'
            a[:y]
          when '3'
            a[:z]
          when '4'
            b[:x]
          when '5'
            b[:y]
          when '6'
            b[:z]
          when '7'
            c[:x]
          when '8'
            c[:y]
          when '9'
            c[:z]
          end
    # loc.class == NilClass ? false : true
    loc.class != NilClass
  end
end
