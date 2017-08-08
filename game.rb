require "byebug"
require_relative "board"
require_relative "mark"
require_relative "player"
require_relative "human_player"
require_relative "computer_player"

class Game
  attr_accessor :board, :human_player, :computer_player, :current_player
  
  def initialize
    @board = Board.new
    @human_player = nil
    @computer_player = nil
    @current_player = nil
  end
  
  def start
    self.pick_players
    self.randomize_order

    @board.print_board
    
    until board.game_over?
      self.play_turn
    end
    
    byebug
  end
  
  # get user's name and chice of mark
  def pick_players
    puts "Hello! Welcome to SJ's TIC TAC TOE. What is your name?"
    name = gets.chomp
    puts "Do you prefer O or X?"
    puts "Please type either O or X and press enter."
    input = gets.chomp.downcase
    
    until input == "o" || input == "x"
      puts "You have entered #{input}. Please type either O or X and press enter instead."
      input = gets.chomp
    end
    
    if input === "o"
      @human_player = HumanPlayer.new(:o, name)
      @computer_player = ComputerPlayer.new(:x)
    elsif input === "x"
      @human_player = HumanPlayer.new(:x, name)
      @computer_player = ComputerPlayer.new(:o)
    end

    puts "Great! You are #{human_player.mark.to_s} and Computer is #{computer_player.mark.to_s}"
  end
  
  # randomize the player to make the first move
  def randomize_order
    puts "Randomly selecting the player to make the first move..."
    @current_player = [@human_player, @computer_player].shuffle[0]
    
    puts "#{@current_player.name} will be going first... Let the game begin!"
  end
  
  
  def play_turn
    @current_player.place_mark(@board)
    self.change_current_player
    @board.print_board
  end
  
  # swap the value of @current_player between human and computer
  def change_current_player
    if @current_player == @human_player
      @current_player = @computer_player
    else
      @current_player = @human_player
    end
  end
  
end


game = Game.new
game.start