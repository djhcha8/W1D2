require "byebug"
require_relative "card.rb"

class Board
attr_reader :grid
VALUES = [ :a, :b, :c, :d, :e, :f, :g, :h]

  def initialize(grid = Array.new(4) { Array.new(4) })
    @grid = grid
  end

  def [](pos)
    row, col = pos
    # debugger
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def won?
    @grid.flatten.all? { |el| el.nil? }
  end

  def populate
    set = generate_set
    (0..grid.length-1).map do |row|
      (0..grid.length-1).map do |col|
        pos = [row, col]
        self[pos] = set.first
        set.shift
      end
    end
  end

  def generate_set
    set_values = VALUES * 2
    cards = []
    set_values.each do |card|
      cards << Card.new(card)
    end
    cards.shuffle
  end

  def reveal(guessed_pos)
    self[guessed_pos].display if self[guessed_pos].face
  end

  def render
    row0 = []
    (0..3).each do |row|
      row0 << [0,row]
    end
    row1 = []
    (0..3).each do |row|
      row1 << [1,row]
    end
    row2 = []
    (0..3).each do |row|
      row2 << [2,row]
    end
    row3 = []
    (0..3).each do |row|
      row3 << [3,row]
    end
    p "----"
    p row0
    p "----"
    p row1
    p "----"
    p row2
    p "----"
    p row3
    p "----"
  end

end
