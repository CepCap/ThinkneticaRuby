require_relative 'wagon'

class PassengersWagon < Wagon
  attr_reader :seats_total
  attr_reader :occupied
  attr_reader :unoccupied

  def initialize(id, seats_total)
    @seats_total = seats_total
    @id = id
    @occupied = 0
    @unoccupied = seats_total
  end

  def occupy
    if occupied <= seats_total
      @occupied += 1
      @unoccupied -= 1
    end
  end

  def unoccupy
    unless @unoccupied.zero?
      @unoccupied += 1
      @occupied -= 1
    end
  end
end
