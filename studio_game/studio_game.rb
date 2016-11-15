class Player
  attr_reader :health, :name

  def initialize(name,health=100)
    @name = name.capitalize
    @health = health
  end

  def to_s
    "I'm #{@name} with a health of #{@health} and a score of #{score}."
  end

  def w00t
    @health += 15
    puts "#{@name} has been w00ted! New health is #{@health}."
  end

  def blam
    @health -= 10
    puts "#{@name} has been blammed! New health is #{@health}."
  end

  def score
    @name.length + @health
  end

  def name=(new_name)
    @name = new_name.capitalize
  end
end

player1 = Player.new("moe")
player2 = Player.new("larry", 60)
player3 = Player.new("curly", 125)

players = [player1,player2,player3]
puts "There are #{players.size} players in this game"
players.pop
players.push(player4 = Player.new("shemp", 90))
puts players
players.each {|p| puts p.health}
players.each {|p| p.w00t; p.blam}
puts player4.name