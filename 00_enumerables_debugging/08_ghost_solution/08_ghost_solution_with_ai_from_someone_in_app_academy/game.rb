require "./player.rb"
require "./ai_player.rb"
require "set"

class Game
  LONG_PAUSE = 3 # seconds
  MEDIUM_PAUSE = 2
  SHORT_PAUSE = 1

  def initialize
    system("clear"); puts "Welcome to GHOST!"
    sleep MEDIUM_PAUSE

    @players = []

    # Get valid number of players
    system("clear"); print "How many players? "
    n = gets.chomp
    until /^[0-9]*$/.match?(n)
      puts "You must enter a number!"
      print "How many players? "
      n = gets.chomp
    end
    n_players = n.to_i

    # Generate a Player instance for each human/AI player ...
    (1..n_players).each do |n|
      system("clear")

      # ... while displaying a visible, running list of current players
      if !@players.empty?
        puts "Players:"
        @players.each { |player| puts "  #{player.name}" }; puts
      end

      puts "Player #{n}, enter your name (or just hit Enter/Return to create an AI player):"
      name = gets.chomp
      if name == ""
        ai_num = @players.count { |player| player.is_a?(AiPlayer) } + 1
        @players << AiPlayer.new("AI #{ai_num}")
        puts "AI player ##{ai_num} created."
      else
        @players << Player.new(name)
        puts "\nWelcome, #{name}!"
      end
      sleep SHORT_PAUSE
    end

    # Generate a random player order, and save that original player order
    # for use in later game information—rendering functions
    @players.shuffle!
    @original_player_order = @players.dup
    @current_player = @players.first

    # Display the order of play to players
    system("clear"); puts "A random player order has been determined."
    @players.each_with_index do |player, i|
      puts "  #{(i + 1).to_s.ljust(3)} #{player.name}"
    end
    
    ### Set game parameters

    # Word of which letters are earned for losing rounds
    @score_str = "GHOST"

    # Set minimum word length
    print "\nSet the minimum number of letters required to complete a word: "
    n = gets.chomp
    until /^[0-9]*$/.match?(n)
      puts "You must enter a number!"
      print "Set the minimum number of letters required to complete a word: "
      n = gets.chomp
    end
    word_length = n.to_i

    # Generate dictionary (Set) of valid words
    @valid_words = Set.new(File.readlines("dictionary.txt"))
                      .map! { |line| line.chomp }
                      .select { |word| word.length >= word_length }

    # Track the word (String) players take turns building
    @fragment = ""

    system("clear"); puts "Let's play GHOST!"
    sleep MEDIUM_PAUSE
  end


  ### Game methods

  def next_player
    @players.rotate!
    @current_player = @players.first
  end

  def take_turn(player)
    system("clear"); puts "#{player.name}, it is your turn."
    puts "\nThe current string is: #{@fragment}"

    guess = player.make_guess(@fragment, @valid_words, (@players.length - 1))
    # @fragment and (@players.length - 1) passed to AiPlayer class;
    # Player (human) class includes these as duck typing

    if player.is_a?(AiPlayer)
      puts "\n#{player.name} has chosen the letter '#{guess}'."
      sleep MEDIUM_PAUSE
    end

    if valid_guess?(guess)
      @fragment += guess
      if !completed_word?
        next_player
      else
        system("clear")
        puts "#{player.name}, you've completed the word \"#{@fragment}\"!"
        puts "You've earned a GHOST letter."
        sleep LONG_PAUSE
        @fragment = ""
        player_loses(player)
      end
    else
      system("clear")
      puts "#{player.name}, the letter you've added to the string cannot result in a legal word!"
      puts "You've earned a GHOST letter."
      sleep LONG_PAUSE
      player_loses(player)
    end
  end

  def render_current_score
    system("clear")
    puts "=" * 30
    puts "CURRENT SCORE".center(30)
    puts "-" * 30
    @original_player_order.each do |player|
      print "#{player.name.ljust(21)}"
      (0...player.losses).each { |i| print "#{@score_str[i]} " }
      print "\n"
    end
    puts "=" * 30
  end

  def valid_guess?(letter)
    test_str = @fragment + letter
    @valid_words.any? { |word| word.start_with?(test_str) }
  end

  def completed_word?
    @valid_words.include?(@fragment)
  end

  def player_loses(player)
    player.earn_letter
    next_player
    if @players[-1].losses == @score_str.length
      puts "\n#{@players[-1].name}, you're a GHOST! You're out of the game!"
      @players.delete_at(-1)
      sleep MEDIUM_PAUSE
      return if @players.length == 1
    end
    if @fragment == ""
      render_current_score
      puts "\n#{@current_player.name} will now begin a new string."
      sleep LONG_PAUSE
    else
      render_current_score
      puts "\nThe current string is: #{@fragment}"
      puts "\n#{@current_player.name}, would you like to continue the current string or start a new string?"
      choice = @current_player.continue_or_new(@fragment, @valid_words)
      if choice == "c"
        puts "\n#{@current_player.name} will continue the current string."
      elsif choice == "n"
        @fragment = ""
        puts "\n#{@current_player.name} will now begin a new string."
      end
      sleep MEDIUM_PAUSE
    end
  end


  ### Run game

  def play
    while @players.length > 1
      take_turn(@current_player)
    end
    system("clear")
    puts "#{@current_player.name}, you win! Congratulations!"
    sleep MEDIUM_PAUSE
    system("clear")
  end
end


if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end
