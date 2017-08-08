class HumanPlayer < Player
  attr_accessor :name, :mark
  
  def initialize(mark, name)
    super(mark)
    @name = name
  end
  
  def self.valid_coord?(board_size, row_coord, col_coord)
    valid_coords = []
    0.upto(board_size - 1) { |idx| valid_coords << idx.to_s }
    valid_coords.include?(row_coord) && valid_coords.include?(col_coord)
  end
  
  def place_mark(board)
    puts "Please enter the coordinates (each between 0-2) you want to mark. e.g. 0,0 for top left corner."
    row_coord, col_coord = gets.chomp.split(",")
    
    until HumanPlayer.valid_coord?(board.size, row_coord, col_coord) && board.empty?([row_coord.to_i, col_coord.to_i])
      puts "Please enter an unoccupied coordinates (each between 0-#{board.size - 1}) you want to mark. e.g. 0,0 for top left corner."
      puts "Also, coordinates must be between 0 and #{board.size - 1}"
      row_coord, col_coord = gets.chomp.split(",")
    end

    board[[row_coord.to_i, col_coord.to_i]] = @mark
  end
  
end