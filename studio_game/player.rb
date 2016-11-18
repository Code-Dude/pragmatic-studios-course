class Player
  attr_reader :health, :name

  def initialize(name,health=100)
    @name = name.capitalize
    @health = health
    @found_treasures = Hash.new(0)
  end

  def to_s
    "I'm #{@name} with health = #{@health}, points = #{points}, and score = #{score}."
  end

  def formatted_name
    "#{@name.ljust(10,'.')}#{score}"
  end

  def self.from_csv(line)
    name, health = line.split(',')
    Player.new(name, Integer(health))
  end

  def w00t
    @health += 15
    puts "#{@name} has been w00ted! New health is #{@health}."
  end

  def blam
    @health -= 10
    puts "#{@name} has been blammed! New health is #{@health}."
  end

  def found_treasure(treasure)
    @found_treasures[treasure.name] += treasure.points
    puts "#{@name} found a #{treasure.name} worth #{treasure.points} points."
    puts "#{@name}'s treasures: #{@found_treasures}"
  end

  def each_found_treasure
    @found_treasures.each do |k,v|
      yield Treasure.new(k,v)
    end
  end

  def score
    @health + points
  end

  def points
    @found_treasures.values.reduce(0,:+)
  end

  def name=(new_name)
    @name = new_name.capitalize
  end

  def strong?
    @health > 100
  end

  def <=>(player)
    player.points <=> points
  end
end