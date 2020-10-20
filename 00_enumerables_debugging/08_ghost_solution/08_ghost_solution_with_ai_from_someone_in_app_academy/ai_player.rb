class AiPlayer
  attr_reader :name, :losses

  def initialize(name)
    @name = name

    @losses = 0
  end

  def make_guess(current_fragment, valid_words, n_other_players)
    valid_guesses = []; losing_guesses = []
    guess = ""

    ("a".."z").to_a.each do |letter|
      test_frag = "#{current_fragment}#{letter}"
      possible_words = valid_words.select do |word| 
        word.start_with?(test_frag) && word != test_frag
      end
      
      lose = possible_words.empty?
      win = !possible_words.empty? && possible_words.all? do |word|
        word.length - test_frag.length <= n_other_players
      end

      if win
        guess = letter
        break
      else
        lose ? losing_guesses << letter : valid_guesses << letter
      end
    end

    if guess == ""
      if !valid_guesses.empty?
        guess = valid_guesses.sample
      else
        guess = losing_guesses.sample
      end
    end
    guess
  end

  def earn_letter
    @losses += 1
  end

  def continue_or_new(current_fragment, valid_words)
    possible_words = valid_words.select do |word|
      word.start_with?(current_fragment)
    end.any? do |word|
      word.length - current_fragment.length > 1
    end
    possible_words ? "c" : "n"
  end
end
