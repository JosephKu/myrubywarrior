class Player
  def play_turn(warrior)
    if warrior.feel.empty?
      (warrior.health < 20 && warrior.health >= @health) ? warrior.rest! : warrior.walk!
    else
      warrior.feel.captive? ? warrior.rescue! : warrior.attack!
    end
    @health = warrior.health
  end
end
