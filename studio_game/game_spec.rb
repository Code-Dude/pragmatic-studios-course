require_relative 'game'

describe Game do

  before do
    @game = Game.new("Knuckleheads")
    @rounds = 2

    @initial_health = 100
    @player1 = Player.new('moe', @initial_health)

    @game.add_player(@player1)
    $stdout = StringIO.new
  end

  it 'w00ts a player when a high number is rolled' do
    allow_any_instance_of(Die).to receive(:roll).and_return(5)

    @game.play(@rounds)

    expect(@player1.health).to eq(@initial_health + 15 * @rounds)
  end

  it 'does nothing when a medium number is rolled' do
    allow_any_instance_of(Die).to receive(:roll).and_return(3)

    @game.play(@rounds)

    expect(@player1.health).to eq(@initial_health)
  end

  it 'blams a player when a low number is rolled' do
    allow_any_instance_of(Die).to receive(:roll).and_return(1)

    @game.play(@rounds)

    expect(@player1.health).to eq(@initial_health - 10 * @rounds)
  end

  it 'assigns a treasure for points during a player\'s turn' do
    game = Game.new('Knuckleheads')
    player = Player.new('moe')

    game.add_player(player)

    game.play(1)

    expect(player.points).not_to be_zero
  end

  context 'has a total points value' do
    it 'has a total point\'s value calculated out.' do
      game = Game.new('Knuckleheads')

      player1 = Player.new('moe')
      player2 = Player.new('larry')

      game.add_player(player1)
      game.add_player(player2)

      player1.found_treasure(Treasure.new(:hammer, 50))
      player1.found_treasure(Treasure.new(:hammer, 50))
      player2.found_treasure(Treasure.new(:crowbar, 400))

      expect(game.total_points).to eq(500)
    end
  end
end