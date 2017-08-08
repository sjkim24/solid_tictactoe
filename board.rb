class Board
  attr_accessor :board
  
  def initialize
    #set up default 3x3 board
    @board = Array.new(3) { Array.new(3) }
  end
  
  def get_unmarked_coords
    coords = []
    # self.board vs @board. check it
    self.board.each_with_index do |row, idx_1|
      row.each_with_index do |mark, idx_2|
        coords << [idx_1, idx_2] if mark.nil?  
      end
    end
    
    coords
  end
  
  # display nil as number from 1 - 9
  def print_board
    self.board.each_with_index.map do |row, idx_1|
      row.each_with_index.map do |mark, idx_2|
        mark = (idx_1 + 1) * (idx_2 + 1) if mark.nil?
      end
      
      p row
    end
  end
  
  def game_over?
    
  end
end