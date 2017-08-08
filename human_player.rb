class HumanPlayer < Player
  attr_reader :name
  
  def initialize(mark, name)
    super(mark)
    @name = name
  end
  
  def place_mark(board)
    # change this to taking int input between 1-9
    puts "Please type the coordinates you want to mark. e.g. [0,0] for top left corner."
    input = gets.chomp
    
    row_coord = input[1].to_i
    col_coord = input[3].to_i
    board.board[row_coord][col_coord] = self.mark
  end
end