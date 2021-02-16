# frozen_string_literal: true

class GameBoard
  def initialize
    @board = [*1...10]
  end

  def game_start
    puts 'Player 1 Enter Name'
    player1 = Player.new(gets.chomp, 'O')
    puts 'Player 2 Enter Name'
    player2 = Player.new(gets.chomp, 'X')
    until check_win
      puts "#{player1.name} select space"
      print_board
      place_piece(player1.icon)
      break if check_win

      puts "#{player2.name} select space"
      print_board
      place_piece(player2.icon)
    end
    print_board
    winner_announce(player1, player2)
  end

  WINNING_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [2, 4, 6],
    [0, 4, 8]
  ].freeze

  private

  def check_int(integer)
    until @board[integer.to_i - 1] == integer.to_i
      puts 'Enter unused number between 1 and 9'
      integer = gets.chomp
    end
    integer
  end

  def print_board
    puts "\n   #{@board[0]} | #{@board[1]} | #{@board[2]}"
    puts '  -----------'
    puts "   #{@board[3]} | #{@board[4]} | #{@board[5]}"
    puts '  -----------'
    puts "   #{@board[6]} | #{@board[7]} | #{@board[8]} \n"
  end

  def place_piece(icon)
    number = check_int(gets.chomp)
    @board[number.to_i - 1] = icon
  end

  def check_win
    WINNING_COMBINATIONS.each do |combo|
      if [@board[combo[0]], + @board[combo[1]], @board[combo[2]]].uniq.length == 1
        @winner = @board[combo[0]]
        return true
      end
    end
    unless @board.any? { |i| i.is_a? Integer }
      @winner = 'Draw'
      true
    end
  end

  def winner_announce(player1, player2)
    case @winner
    when 'O'
      puts "#{player1.name} wins. Congratulations"
    when 'X'
      puts "#{player2.name} wins. Congratulations"
    when 'Draw'
      puts "It's a tie, what else did you expect?"
    else puts 'Well done breaking the game'
    end
  end
end

class Player
  attr_reader :name, :icon

  def initialize(name, icon)
    @name = name
    @icon = icon
  end
end

game = GameBoard.new
game.game_start
puts 'want to play again? Y/N'
if gets.chomp.downcase == 'y'
  game.game_start
  puts 'want to play again? Y/N'
  until gets.chomp.downcase == 'n'
    game.game_start
    puts 'want to play again? Y/N'
  end
end
puts 'Thank you for playing'
