require_relative "board.rb"
require "byebug"

class Game
attr_reader :player1, :player2, :board, :current_player, :previous_guess

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = Board.new
    @board.populate
    @current_player = player1
    @previous_guess = nil
    @scores = Hash.new(0)
    # debugger
  end

  def prompt
    puts "#{@current_player} guess a position (x,y)"
  end

  def get_guess
    prompt
    gets.chomp.split(",").map(&:to_i)
  end

  def make_guess(guess1, guess2)
    pos1 = @board[guess1]
    pos2 = @board[guess2]
    if pos1.value == pos2.value
      puts "found a match!"
       @board[guess1] = nil
       @board[guess2] = nil
       @scores[@current_player] += 1
    else
      puts "no match. next player!"
      @board[guess1].hide
      @board[guess2].hide
    end
  end

  def switch_player!
    @current_player = @current_player == player1 ? player2 : player1
  end

  def empty_space?(pos)
    # debugger
    @board[pos].nil?
  end

  def pick_card
    get_guess
  end

  def play
    until over?
      take_turn
    end
    winner = @scores.sort_by { |k, v| v }.first
    puts "#{winner} WINS!"
  end

  def take_turn
    # debugger
    @board.render
    @previous_guess = nil
    @current_guess = get_guess
    if @current_guess.none? { |el| el >= 4 } && !empty_space?(@current_guess)
      @previous_guess = @current_guess
      @current_guess = get_guess
      if @current_guess.none? { |el| el >= 4 } && !empty_space?(@current_guess) && @current_guess != @previous_guess
        make_guess(@previous_guess, @current_guess)
        switch_player!
      else
        puts "invalid move, guess again!"
        take_turn
      end
    else
      puts "invalid move, guess again!"
      take_turn
    end
  end

  def over?
    # debugger
    @board.won?
  end
end

if __FILE__ == $PROGRAM_NAME
  gg = Game.new("David", "Ross")
  gg.play
end
