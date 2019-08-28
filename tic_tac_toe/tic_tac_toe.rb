# frozen_string_literal: true

require_relative 'board.rb'

puts '******************************************************************'
puts '***************** Tic Tac Toe by Franklyn Afeso ******************'
puts '******************************************************************'
puts '***** Each Player gets a Turn to Choose a Location. First to *****'
puts '***** get 3 of their letters to match (up, down, cross) wins *****'
puts '******************************************************************'
puts '****** Below, is the Board\'s Layout, and its Location Keys ******'
puts '  **************************** |1|2|3| *************************  '
puts '  **************************** |4|5|6| *************************  '
puts ' ***************************** |7|8|9| ************************** '
puts '***************************** HAVE  FUN **************************'

# Player Class
class Player
  def initialize(char)
    @char = char
  end

  attr_reader :char
end

module Playable
  X = Player.new('x')
  O = Player.new('o')
  GAME_BOARD = Board.new
end

# game_board = Board.new

def play_game
  board = Playable::GAME_BOARD

  puts 'Player X, choose a location:'
  x_loc = gets.chomp.downcase
  board.update(x_loc, Playable::X.char)
  return board.check unless board.check.nil?

  puts 'Player O, choose a location:'
  o_loc = gets.chomp.downcase
  board.update(o_loc, Playable::O.char)
  return board.check unless board.check.nil?

  play_game if board.check.nil?
end

puts play_game
