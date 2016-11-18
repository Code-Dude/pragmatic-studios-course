require_relative 'player'
require_relative 'treasure_trove'

describe Player do
  before do
    @initial_health = 150
    @player1 = Player.new('larry', @initial_health)
    $stdout = StringIO.new
  end

  it 'has a capitalized name' do
    expect(@player1.name).to eq('Larry')
  end

  it 'has an initial health' do
    expect(@player1.health).to eq(@initial_health)
  end

  it 'has a string representation' do
    expect(@player1.to_s).to eq("I'm #{@player1.name} with health = #{@player1.health}, points = #{@player1.points}, and score = #{@player1.score}.")
  end

  it 'increases health by 15 when w00ted' do
    @player1.w00t

    expect(@player1.health).to eq(@initial_health + 15)
  end

  it 'decreases health by 10 when blammed' do
    @player1.blam

    expect(@player1.health).to eq(@initial_health - 10)
  end

  it 'computes score as the sum of all treasure points' do
    expect(@player1.points).to eq(0)

    @player1.found_treasure(Treasure.new(:hammer, 50))

    expect(@player1.points).to eq(50)

    @player1.found_treasure(Treasure.new(:crowbar, 400))

    expect(@player1.points).to eq(450)

    @player1.found_treasure(Treasure.new(:hammer, 50))

    expect(@player1.points).to eq(500)
  end

  it 'computes a score as the sum of its health and points' do
    @player1.found_treasure(Treasure.new(:hammer, 50))
    @player1.found_treasure(Treasure.new(:hammer, 50))

    expect(@player1.score).to eq(250)
  end

  it 'yields each found treasure and its total points' do
    @player1.found_treasure(Treasure.new(:skillet, 100))
    @player1.found_treasure(Treasure.new(:skillet, 100))
    @player1.found_treasure(Treasure.new(:hammer, 50))
    @player1.found_treasure(Treasure.new(:bottle, 5))
    @player1.found_treasure(Treasure.new(:bottle, 5))
    @player1.found_treasure(Treasure.new(:bottle, 5))
    @player1.found_treasure(Treasure.new(:bottle, 5))
    @player1.found_treasure(Treasure.new(:bottle, 5))

    yielded = []
    @player1.each_found_treasure do |treasure|
      yielded << treasure
    end

    expect(yielded).to eq([
        Treasure.new(:skillet, 200),
        Treasure.new(:hammer, 50),
        Treasure.new(:bottle, 25)
    ])
  end

  context 'A player with a high health value is strong' do
    before do
      @player1 = Player.new('Test', 150)
    end

    it 'returns true if player is strong?' do
      expect(@player1).to be_strong
    end
  end

  context 'A player with a normal health isn\'t strong' do
    before do
      @player1 = Player.new('Test', 100)
    end

    it 'returns false when strong? is called' do
      expect(@player1).not_to be_strong
    end
  end

  context 'in a collection of players' do
    before do
      @player1 = Player.new('moe', 100)
      @player2 = Player.new('larry', 200)
      @player3 = Player.new('curly', 300)
      @player3.found_treasure(Treasure.new(:crowbar, 400))
      @player2.found_treasure(Treasure.new(:broomstick, 200))

      @players = [@player1, @player2, @player3]
    end

    it 'is sorted by decreasing points' do
      expect(@players.sort).to  eq([@player3, @player2, @player1])
    end
  end
end