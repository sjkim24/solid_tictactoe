class ComputerPlayer < Player
  attr_reader :name, :mark

  def initialize(mark)
    super(mark)
    @name = "Computer"
  end
  
  # computer will randomly place a mark by shuffling an array of coordinate arrays
  # and then choosing the first coordinate array
  def place_mark(board)
    unmarked_coords = board.get_unmarked_coords
    random_coord = unmarked_coords.shuffle[0]
    row_coord = random_coord[0]
    col_coord = random_coord[1]
    puts "Computer has placed a #{@mark} at #{random_coord}"
    # byebug
    board[[row_coord, col_coord]] = @mark
  end
  
end