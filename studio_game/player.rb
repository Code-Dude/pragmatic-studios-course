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