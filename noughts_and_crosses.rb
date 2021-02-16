require 'pry'
class GameBoard
  def initialize
    @board =
      [{
        position1: 1,
        position2: 2,
        position3: 3,
        position4: 4,
        position5: 5,
        position6: 6,
        position7: 7,
        position8: 8,
        position9: 9
      }]
  end

  def print_board
    puts "\n   #{@board[:position1]} | #{@board[:position2]} | #{@board[:position3]}"
    puts '  -----------'
    puts "   #{@board[:position4]} | #{@board[:position5]} | #{@board[:position6]}"
    puts '  -----------'
    puts "   #{@board[:position7]} | #{@board[:position8]} | #{@board[:position9]} \n"
  end

  def place_piece(icon)
    number = check_int(gets.chomp)
    @board[('position' + number.to_s).to_sym] = icon
  end

  def check_win; end

  private

  def check_int(integer)
    until @board[('position' + integer.to_s).to_sym] == integer.to_i
      puts 'Enter unused number between 1 and 9'
      integer = gets.chomp
    end
    integer
  end
end

class Player
  attr_reader :name, :icon

  def initialize(name, icon)
    @name = name
    @icon = icon
  end
end

def game_start
  game = GameBoard.new
  puts 'Player 1 Enter Name'
  player1 = Player.new(gets.chomp, 'O')
  puts 'Player 2 Enter Name'
  player2 = Player.new(gets.chomp, 'X')
  until game.check_win
    puts 'Player 1 select space'
    game.print_board
    game.place_piece(player1.icon)
    game.check_win
    puts 'Player 2 select space'
    game.print_board
    game.place_piece(player2.icon)
  end
end
game_start
until gets.chomp.downcase == 'n'
  puts 'want to play again?'
  game_start
end
