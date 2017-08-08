class Board
  attr_accessor :rows
  
  def initialize
    #set up default 3x3 board
    @rows = Array.new(3) { Array.new(3) }
  end
  
  # self[0][1] is same as self.[]([0][1])
  def [](pos)
    # byebug
    row, col = pos
    
    @rows[row][col]
  end
  # 
  def []=(pos, mark)
    # raise "Mark is already placed there!" unless empty?(pos)
    row, col = pos
    @rows[row][col] = mark
  end
  
  def get_unmarked_coords
    coords = []
    
    @rows.each_with_index do |row, idx_1|
      row.each_with_index do |mark, idx_2|
        coords << [idx_1, idx_2] if mark.nil?  
      end
    end
    
    coords
  end
  
  # display nil as number from 1 - 9
  def print_board
    @rows.each_with_index.map do |row, idx_1|
      row.each_with_index.map do |mark, idx_2|
        mark = (idx_1 + 1) * (idx_2 + 1) if mark.nil?
      end
      
      p row
    end
  end
  
  def empty?(pos)
    self[pos].nil?
  end
  
  def game_over?
    won? || tied?
  end
  
  def cols
  cols = [[], [], []]

  @rows.each do |row|
    row.each_with_index do |mark, col_idx|
      cols[col_idx] << mark
    end
  end

    cols
  end

  def diagonals
    down_diag = [[0, 0], [1, 1], [2, 2]]
    up_diag = [[0, 2], [1, 1], [2, 0]]

    [down_diag, up_diag].map do |diag|
      diag.map { |pos| self[pos] }
    end
  end
  
  def winner
    (@rows + cols + diagonals).each do |triple|
      return :x if triple == [:x, :x, :x]
      return :o if triple == [:o, :o, :o]
    end
    
    nil
  end
  
  def won?
    !winner.nil?
  end
  
  def tied?
    return false if won?
    
    @rows.all? { |row| row.all? }
  end
end