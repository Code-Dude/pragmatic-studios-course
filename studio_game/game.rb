class Game
  attr_reader :title

  def initialize(title)
    @title = title
    @players = Array.new
  end

  def add_player(player)
    @players << player
  end

  def play
    puts "There are #{@players.size} players in #{@title}:"
    puts @players
    @players.each {|p|p.w00t;p.w00t;p.blam;puts p}
  end
end