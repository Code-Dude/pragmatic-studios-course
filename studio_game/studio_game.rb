player1 = 'larry'
player2 = 'curly'
player3 = 'moe'
player4 = 'shemp'

player1_health = 60
player2_health = 120
player3_health = 100
player4_health = 90

puts "#{player1.capitalize} has a health of #{player1_health}."
puts "#{player2.upcase} has a health of #{player2_health}."
puts "#{player3.capitalize} has a health of #{player3_health}".center(50,"*")
puts "#{player4.capitalize.ljust(20,".")}#{player4_health} health."

puts Time.new.strftime("The game started on %A %m/%d/%Y at %I:%M")