class Player
  def play_turn(warrior)
    @health = warrior.health if @health.nil?
    @direction = :forward if @direction.nil?
 
    if warrior.feel(@direction).wall?
      warrior.pivot! :backward
      return
    end

    if captive_behind?(warrior)
      warrior.pivot! :backward
      return
    end

    if archer_behind?(warrior)
      warrior.walk!(@direction) if warrior.feel(@direction).empty?
      return
    end

    if warrior.feel(@direction).empty?
      if no_enemy?(warrior)
        warrior.walk!
        return
      end

      if shoot?(warrior)
        warrior.shoot!
      elsif warrior.health < @health
        warrior.health > 6 ? warrior.walk! : warrior.walk!(:backward)
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
    warrior.look(@direction).each_with_index do |s, i|
      if s.enemy?
        if i == 0
          return false
        else
          return true
        end
      end
      return false if s.to_s == "Captive"
    end
    return false
  end

  def captive_behind?(warrior)
    warrior.look(:backward).each do |s|
      return true if s.to_s == "Captive"
    end
    return false
  end
  
  def no_enemy?(warrior)
    warrior.look(@direction).each do |s|
      return false if s.enemy?
    end
    return true
  end

  def archer_behind?(warrior)
    warrior.look(:backward).each do |s|
      return true if s.to_s == "Archer"
    end
    return false
  end
end
