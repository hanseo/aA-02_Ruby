require "set"

class AiPlayer
  attr_reader :name
  ALPHABET = ("a".."z").to_a

  def initialize
    @name = "AiPlayer"
  end

  def all_possible_w(dictionary, fragment)
    poss = dictionary.select { |w| w.start_with?(fragment) }
    Set.new(poss)
  end

  def all_wins(possible_words, fragment_sz, num_players)
    wins = possible_words.select do |w|
      w.length - fragment_sz != 1 && w.length - fragment_sz != num_players
    end

    Set.new(wins)
  end

  def false_positives(winning_words, losing_words)
    winning_words.select do |win_w|
      losing_words.any? { |los_w| win_w.start_with?(los_w) }
    end
  end

  def guess(fragment, dictionary, players)
    puts "#{name}'s guess:"

    if fragment.empty?
      random_letter = ALPHABET.sample
      puts random_letter
      return random_letter
    end

    possible_words = all_possible_w(dictionary, fragment)
    winning_words = all_wins(possible_words, fragment.length, (players.length + 1))
    losing_words = possible_words - winning_words
    false_pos = false_positives(winning_words, losing_words)

    winning_words.subtract(false_pos)
    losing_words.merge(false_pos) if !false_pos.empty? 
  
    if winning_words.empty?
      word = losing_words.max_by(&:length)
    else
      word = winning_words.to_a.sample
    end

    puts word[fragment.length]
    word[fragment.length]
  end
end