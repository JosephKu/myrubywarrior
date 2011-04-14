class Player
  def play_turn(warrior)
    @health = warrior.health if @health.nil?
    @captive_rescued.nil? ? @direction = :backward : @direction = :forward
    if warrior.feel(@direction).empty?
      if warrior.health < @health
        warrior.health > 7 ? warrior.walk! : warrior.walk!(:backward) # Magic number 7!
      elsif warrior.health < 20
        warrior.rest!
      else
        warrior.walk!(@direction)
      end
    else
      if warrior.feel(@direction).captive?
        warrior.rescue!(@direction)
        @captive_rescued = true
      else
        warrior.attack!(@direction)
      end
    end
    @health = warrior.health
  end
end
