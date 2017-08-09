class Game
  require "colorize"
  attr_accessor :board, :human_player, :computer_player, :current_player, :prev_player
  
  def self.ask_for_input(message)
    puts ""
    puts "#{message}".colorize(:green)
    
    gets.chomp
  end
  
  def self.print_error(message, instruction)
    puts message.colorize(:red)
    puts instruction
  end
  
  def start(reset = false)
    self.setup_board_size if !reset
    self.setup_players if !reset
    self.randomize_order

    @board.print_board
    
    until board.game_over?
      self.play_turn
    end
    
    self.end_game
  end
  
  def setup_board_size
    begin
      board_size_input = Game.ask_for_input("Hello, welcome to Tic to the Tac to the Toe yo. Would you like to select a differnt board size? Default is 3x3  [y/n]").downcase
      raise ArgumentError.new("Invalid Input!") if (board_size_input != "y" && board_size_input != "n")
    rescue ArgumentError => e
      Game.print_error(e.message, "You entered #{board_size_input}. Please enter y or n.")
      retry
    end
  
    
    if board_size_input == "y"
      begin
        board_size_num_input = Game.ask_for_input("Please enter a board size. e.g. enter 5 for 5x5 board")
        raise ArgumentError.new("Invalid Input!") if (board_size_num_input.to_i.to_s != board_size_num_input || board_size_num_input.to_i < 3)
      rescue ArgumentError => e
        Game.print_error(e.message, "You entered #{board_size_num_input}. Please eneter a numeric value greater than 2")
        retry
      end
    end
    
    board_size_num_input ||= 3
    
    @board = Board.new(board_size_num_input.to_i)
  end
  
  
  # get user's name and chice of mark
  def setup_players
    player_name_input = Game.ask_for_input("What is your name?")
    
    begin
      mark_pref_input = Game.ask_for_input("Do you prefer O or X? Please type either O or X and press enter.").downcase
      raise ArgumentError.new("Invalid Input!") if (mark_pref_input != "o" && mark_pref_input != "x")
    rescue ArgumentError => e
      Game.print_error(e.message, "You have entered #{mark_pref_input}. Please type either O or X and press enter instead.")
      retry
    end

    if mark_pref_input === "o"
      @human_player = HumanPlayer.new(:o, player_name_input)
      @computer_player = ComputerPlayer.new(:x)
    elsif mark_pref_input === "x"
      @human_player = HumanPlayer.new(:x, player_name_input)
      @computer_player = ComputerPlayer.new(:o)
    end

    puts "Great! You are #{human_player.mark.to_s} and Computer is #{computer_player.mark.to_s}".colorize(:green)
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
    puts ""
    @board.print_board
  end
  
  # swap the value of @current_player between human and computer
  def change_current_player
    if @current_player == @human_player
      @current_player = @computer_player
      @prev_player = @human_player
    else
      @current_player = @human_player
      @prev_player = @computer_player
    end
  end
  
  def end_game
    if @board.won?
      winning_mark = @board.winner
      winner = @current_player
      puts "Congratulation #{@prev_player.name}. You won!".colorize(:blue)
    elsif @board.tied?
      puts "Draw!".colorize(:blue)
    end
    
    self.prompt_restart
  end
  
  def prompt_restart
    begin
      restart_input = Game.ask_for_input("Would you like to restart the match? [y/n]").downcase
      raise ArgumentError.new("Invalid Input!") if (restart_input != "y" && restart_input != "n")
    rescue ArgumentError => e
      Game.print_error(e.message, "You entered #{restart_input}. Please enter y or n")
      retry
    end
    
    restart_input == "y" ? self.restart_match : (puts "Thank you for playing!".colorize(:blue))
  end
  
  def restart_match
    @board.reset
    self.start(true)
  end
  
end