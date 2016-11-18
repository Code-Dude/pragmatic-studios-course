require_relative 'player'
require_relative 'game'

game = Game.new('Knuckleheads')
game.load_players(ARGV.shift || 'players.csv')

loop do
  puts "Enter how many rounds you'd like. Or 'quit','exit'"
  rounds = gets.chomp.downcase
  case rounds
    when /^\d+$/
      game.play(rounds.to_i) do
        game.total_points >= 2000
      end
    when 'quit', 'exit'
      game.print_stats
      game.save_high_scores
      break
    else
      puts "Please enter a number or 'quit'"
  end
end