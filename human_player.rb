class HumanPlayer < Player
  attr_reader :name, :mark
  
  def initialize(mark, name)
    super(mark)
    @name = name
  end
  
  def place_mark(board)
    puts "Please enter the coordinates (each between 0-2) you want to mark. e.g. 0,0 for top left corner."
    row_coord, col_coord = gets.chomp.split(",")
    
    until HumanPlayer.valid_coord?(row_coord, col_coord)
      puts "Coordinates have be between 0 and 2"
      puts "Please enter the coordinates (each between 0-2) you want to mark. e.g. 0,0 for top left corner."
      row_coord, col_coord = gets.chomp.split(",")
    end

    board[[row_coord.to_i, col_coord.to_i]] = @mark
  end
  
  def self.valid_coord?(row_coord, col_coord)
    %w{0 1 2}.include?(row_coord) && %w{0 1 2}.include?(col_coord)
  end
end