require "set"
require_relative "player.rb"
require_relative "aiplayer.rb"

class Game
  def initialize(*players)
    @players = []
    @losses = {}

    players.each do |player| 
      p = Player.new(player)
      @players << p
      @losses[p] = 0
    end

    @fragment = ""
    words = File.readlines("dictionary.txt").map(&:chomp)
    @dictionary = Set.new(words)
    ai = AiPlayer.new
    @players << ai
    @losses[ai] = 0
  end

  def current_player
    @players[0]
  end

  def previous_player
    @players[-1]
  end

  def next_player!
    @players.rotate!
  end

  def valid_play?(string)
    if @dictionary.any? { |w| w.start_with?(@fragment + string) }
      @fragment += string
      return true
    end

    false
  end

  def take_turn(player)
    until valid_play?(player.guess(@fragment, @dictionary, @players))
      p "invalid move"
    end
  end

  def play_round
    until @dictionary.include?(@fragment)
      take_turn(current_player)
      next_player!
    end
    puts "#{previous_player.name} lost this round"
    record(previous_player)
  end

  def record(player)
    @losses[player] += 1
  end

  def run
    until @losses.length == 1
      @fragment = ""
      play_round 
      display_standings
      puts "---------------------------"
    
      if @losses.value?(5)
        loser = @losses.key(5)
        puts "#{loser.name} IS OUT OF THE GAME"
        remove_player(loser)
      end
    end

    puts "#{@losses.keys.first.name} WON!"
  end

  def display_standings
    ghost = "GHOST"
    @losses.each do |k, v| 
      puts " #{k.name} - #{ghost[0...v]}"
    end
  end

  def remove_player(player)
    @losses.delete(player)
    @players.delete(player)
  end
end

if $PROGRAM_NAME == __FILE__
  game = Game.new( "Gizmo", "Breakfast", "Toby", "Leonardo")
  game.run
end
