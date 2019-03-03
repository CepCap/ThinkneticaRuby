require_relative 'wagon'

class CargoWagon < Wagon
  attr_reader :volume_total
  attr_reader :volume_empty
  attr_reader :volume_filled

  def initialize(id, volume_total)
    @id = id
    @volume_total = volume_total
    @volume_filled = 0
    @volume_empty = volume_total
  end

  def fill(amount)
    if @volume_filled <= amount
      @volume_filled += amount 
      @volume_empty -= amount
    else
      return false
    end
  end

  def empty(amount)
    unless @volume_empty == 0
      @volume_empty += amount
      @volume_filled -= amount
    else 
      return false
    end
  end

end
