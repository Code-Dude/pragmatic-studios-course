require_relative 'player'
require_relative 'die'
require_relative 'game_turn'
require_relative 'treasure_trove'

class Game
  attr_reader :title

  def initialize(title)
    @title = title
    @players = Array.new
  end

  def add_player(player)
    @players << player
  end

  def sort_health_array(array)
    array.sort {|a,b|b.health <=> a.health}
  end

  def total_points
    @players.reduce(0) { |sum, player| sum + player.points }
  end

  def load_players(from_file)
    File.readlines(from_file).each do |line|
      add_player(Player.from_csv(line))
    end
  end

  def print_stats
    strong, weak = @players.partition {|p| p.strong?}
    puts "\n#{strong.length} strong players:"
    puts sort_health_array(strong)

    puts "\n#{weak.length} weak players:"
    puts sort_health_array(weak)

    @players.sort.each do |player|
      puts "\n#{player.name}'s point totals:"
      treasures_seperated = []
      player.each_found_treasure {|t| treasures_seperated << t}
      puts treasures_seperated
      puts "\n#{player.points} grand total points"
    end

    puts "\nHigh Scores for #{@title}"
    @players.sort.each {|p|puts p.formatted_name}

    puts "\nTotal Points for #{@title}\n#{total_points}"
  end

  def save_high_scores(to_file='high_scores.txt')
    File.open(to_file, 'w') do |file|
      file.puts "#{@title} High Scores"
      @players.sort.each do |p|
        file.puts p.formatted_name
      end
    end
  end

  def play(rounds)
    treasures = TreasureTrove::TREASURES

    puts "There are #{@players.size} players in #{@title}:"
    puts @players

    puts "\nThere are #{treasures.length} treasures to be found:"
    treasures.each {|t| puts "A #{t.name} is worth #{t.points} points"}
    1.upto(rounds) do |round|
      if block_given?
        break if yield
      end
      puts "\nRound #{round}:"
      @players.each do |p|
        GameTurn.take_turn(p)
      end
    end
  end
end