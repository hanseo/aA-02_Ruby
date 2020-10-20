
require "set"

class Player
  attr_reader :name
  ALPHABET = Set.new("a".."z")

  def initialize(name)
    @name = name    
  end

  def guess(*fragment_parameter)
    puts "#{name}'s guess:"
    letter = gets.chomp.downcase

    return letter if letter.length == 1 && ALPHABET.include?(letter)

    alert_invalid_guess
    guess(*fragment_parameter)
  end

  def alert_invalid_guess
    puts "Invalid Guess, your guess must be 1 letter."
    puts "Try again"
  end
end