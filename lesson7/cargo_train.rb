require_relative 'train'
require_relative 'cargo_wagon'
require_relative 'passengers_wagon'

class CargoTrain < Train

  def hook_wagon(wagon)
    if wagon.is_a? CargoWagon
      super
    else
      puts "Вагон не грузовой."
    end
  end

  def unhook_wagon(wagon)
    if wagon.is_a? CargoWagon
      super
    else
      puts "Вагон не грузовой."
    end
  end
end
