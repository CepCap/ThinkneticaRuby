require_relative 'train'
require_relative 'cargo_wagon'
require_relative 'passengers_wagon'

class PassengersTrain < Train

  def hook_wagon(wagon)
    if wagon.is_a? PassengersWagon
      super
    else
      puts "Вагон не пассажирский."
    end
  end

  def unhook_wagon(wagon)
    if wagon.is_a? PassengersWagon 
      super
    else
       puts "Вагон не пассажирский."
    end
  end
end