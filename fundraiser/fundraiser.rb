class Project
  attr_accessor :name, :target_funding
  attr_reader :current_funding

  def initialize(name,current_funding=0,target_funding)
    @name = name
    @current_funding = current_funding
    @target_funding = target_funding
  end

  def to_s
    "#{@name} has $#{@current_funding} towards its $#{@target_funding} goal!"
  end

  def lose_funds(loss_amount=15)
    @current_funding -= loss_amount
    puts "#{@name} just lost $#{loss_amount} in funding!"
  end

  def gain_funds(gain_amount=25)
    @current_funding += gain_amount
    puts "#{@name} just gained $#{gain_amount} in funding!"
  end

  def remaining_needed
    @target_funding - @current_funding
  end
end

project1 = Project.new('ABC',0,1000)
puts project1
project1.lose_funds
project1.gain_funds
puts project1.remaining_needed
puts project1.current_funding
puts project1.target_funding
project1.name = 'test name'
puts project1.name
