class Board
  attr_accessor :rows, :size
  
  # board size is 3 by default
  def initialize(size = 3)
    @size = size
    @rows = Array.new(size) { Array.new(size) }
  end
  
  def [](pos)
    row, col = pos
    
    @rows[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    @rows[row][col] = mark
  end
  
  def print_board
    @rows.each { |row| p row }
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
  
  def empty?(pos)
    self[pos].nil?
  end
  
  def game_over?
    won? || tied?
  end
  
  def won?
    !winner.nil?
  end
  
  def tied?
    return false if won?
    
    @rows.all? { |row| row.all? }
  end
  
  # check each formatted row (3 rows), cols (3 cols) and diagonals (2 diagonals)
  def winner
    (@rows + cols + diagonals).each do |row|
      return :x if row.all? { |mark| mark == :x }
      return :o if row.all? { |mark| mark == :o }
    end
    
    nil
  end
  
  # get all columns in horizontal format
  def cols
    cols = Array.new(@size) { Array.new(@size) }

    @rows.each do |row|
      row.each_with_index do |mark, col_idx|
        cols[col_idx] << mark
      end
    end

    cols
  end
  
  # get all diagonals in horizontal format
  def diagonals
    down_diag = []
    up_diag = []
    
    # push sets of coordinates that make up both diagonals
    0.upto(@size - 1) do |idx|
      down_diag << [idx, idx]
      up_diag << [idx, @size - 1 - idx]
    end

    [down_diag, up_diag].map do |diag|
      diag.map { |pos| self[pos] }
    end
  end
  
  def reset
    @rows = Array.new(@size) { Array.new(@size) }
  end
end