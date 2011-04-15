class Player
  def play_turn(warrior)
    @health = warrior.health if @health.nil?
    @direction = :forward if @direction.nil?  

    if warrior.feel(@direction).wall?
      warrior.pivot! :backward
      return
    end

    if warrior.feel(@direction).empty?
      if shoot?(warrior)
        warrior.shoot!
      elsif warrior.health < @health
        warrior.health > 7 ? warrior.walk! : warrior.walk!(:backward) # Magic number 7!
      elsif warrior.health < 20
        warrior.rest! 
      else
        warrior.walk!(@direction)
      end
    else
      if warrior.feel(@direction).captive?
        warrior.rescue!(@direction)
      else
        warrior.attack!(@direction)
      end
    end
    @health = warrior.health
  end

  def shoot?(warrior)
    warrior.look(@direction).each do |s|
      case s.to_s
      when "Captive"
        return false
      when "Wizard"
        return true
      end
    end
    return false
  end
end
