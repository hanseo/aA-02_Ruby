class Player
  attr_reader :name, :losses

  def initialize(name)
    @name = name

    @losses = 0
  end

  def make_guess(current_fragment, valid_words, n_other_players)
    # args are present for duck typing purposes only (see AiPlayer class)

    print "\nChoose a letter to add to the string: "
    letter = gets.chomp
    until /^[A-Za-z]{1}$/.match?(letter)
      puts "You must choose a single letter of the alphabet!"
      print "Choose a letter to add to the string: "
      letter = gets.chomp
    end
    letter.downcase
  end

  def earn_letter
    @losses += 1
  end

  def continue_or_new(current_fragment, valid_words)
    print "Type \"c\" for continue; type \"n\" for new: "
    choice = gets.chomp.downcase
    until choice == "c" || choice == "n"
      puts "Invalid entry."
      print "Type \"c\" for continue; type \"n\" for new: "
      choice = gets.chomp.downcase
    end
    choice
  end
end
