require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passengers_train'
require_relative 'cargo_wagon'
require_relative 'instance_counter'

@trains = []
@stations = []
@routes = []
@wagons = []

def create_station
  puts "Введите название станции"
  name = gets.chomp
  station = Station.new(name)
  @stations << station
end

def create_train
  puts "Введите тип (Грузовой, Пассажирский) поезда: "
  type = gets.chomp.downcase
  if type == "пассажирский"
    type = :passengers
  elsif type == "грузовой"
    type = :cargo
  else
    puts "Введите либо пассажирский, либо грузовой тип."
    type = nil
  end
  if type
    puts "Введите модель поезда: "
    model = gets.chomp
    puts "Введите номер поезда: "
    id = gets.to_i
    train = CargoTrain.new(model, id) if type == :cargo
    train = PassengersTrain.new(model, id) if type == :passengers
    @trains << train
    puts train
  end
end

def create_route
  puts "Доступные станции: "
  @stations.each { |station| puts station.name}
  puts "Выберите начальную станцию: "
  start = gets.chomp
  start_station = @stations.find { |station| station.name.downcase == start.downcase}
  puts "Выберите конечную станцию: "
  finish = gets.chomp
  finish_station = @stations.find { |station| station.name.downcase == finish.downcase}
  @routes << Route.new(start_station, finish_station)
end

def route_assign
  puts "Выберите номер поезда: "
  @trains.each_with_index { |train, index| print "#{index}. => "; puts train.model }
  chosen_train = gets.to_i
  puts "Выберите номер маршрута: "
  @routes.each_with_index { |route, index| print "#{index}. => "; route.stations.each { |station| puts station.name } }
  chosen_route = gets.to_i
  @trains[chosen_train].route_get(@routes[chosen_route])
end

def wagon_create
  puts "Введите номер вагона: "
  wagon_id = gets.to_i
  puts "Введите тип вагона (Грузовой, Пассажирский): "
  wagon_type = gets.chomp.to_s
  if wagon_type.downcase == "грузовой" 
    puts "Введите объем вагона."
    wagon_value = gets.to_i
    @wagons << CargoWagon.new(wagon_id, wagon_value)
  elsif wagon_type.downcase == "пассажирский"
    puts "Введите кол-во пассажирских мест"
    wagon_seats = gets.to_i
    @wagons << PassengersWagon.new(wagon_id, seats)
  else
    puts "Введите грузовой или пассажирский тип."
  end
end

def stations_show
  @stations.each do |station|
    puts "Станция: #{station.name}" 
    puts "Поездов на станции #{station.name}:"
    station@trains.each { |train| puts train.model }
  end
end

def wagon_use
  puts "Выберите номер поезда:"
  @trains.each_with_index { |train, index| print "#{index}. => "; puts train.model }
  chosen_train = gets.to_i
  train = @trains[chosen_train]
  puts "Выберите номер вагона: "
  @wagons.each_with_index { |wagon, index| print "#{index}. => "; puts wagon.id }
  chosen_wagon = gets.to_i
  wagon = @wagons[chosen_wagon]
  puts "Вы хотите прицепить или отцепить вагон?"
  choice = gets.chomp.downcase
  if choice == "прицепить"
    train.hook_wagon(wagon)
  elsif choice == "отцепить"
    train.unhook_wagon(wagon)
  else
    puts "Выберите корректное действие."
  end
end

def route_change
  puts "Выберите номер маршрута: "
  @routes.each_with_index { |route, index| print "#{index}. => "; puts route@stations }
  chosen_route = gets.to_i
  route = @routes[chosen_route]
  puts "Вы хотите добавить или удалить промежуточную станцию?"
  input = gets.chomp.downcase
  if input == "добавить"
    puts "Какую станцию вы хотите добавить?"
    @stations.each_with_index { |station, index| print "#{index}. => "; puts station.name }
    chosen_station = gets.to_i
    station = @stations[chosen_station]
    route.intermediate_station_add(station)
  elsif input == "удалить"
    puts "Какую станцию вы хотите удалить?"
    @stations.each_with_index { |station, index| print "#{index}. => "; puts station.name }
    chosen_station = gets.to_i
    station = @stations[chosen_station]
    route.intermediate_station_delete(station)
  else
    puts "Выберите корректное действие."
  end
end

def show_wagons
  puts "Выберите поезд."
  @trains.each_with_index { |train, index| print "#{index}. => "; puts train.model }
  chosen_train = gets.to_i
  train = @trains[chosen_train]
  train.each_wagon do |wagon|   
    puts "Номер вагона: #{wagon.id}, Тип вагона: #{wagon.class}"
    if wagon.is_a? CargoWagon
      puts "Вместимость вагона = #{wagon.volume_total}.\nЗанятый объем = #{wagon.volume_filled}.\nСвободный объем = #{wagon.volume_empty}"
    else
      puts "Всего пассажирских сидений = #{wagon.seats_total}.\nЗанятые места = #{wagon.occupied}.\nСвободные места = #{wagon.unoccupied}"
    end
  end
end

def change_wagons
  puts "Выберите поезд"
  @trains.each_with_index { |train, index| print "#{index}. => "; puts train.model }
  chosen_train = gets.to_i
  train = @train[chosen_train]
  wagons = []
  train.each_wagon { |wagon| wagons << wagon }
  puts "Выберите вагон"
  wagons.each_with_index { |wagon, index| print "#{index}. => "; puts wagon.id }
  chosen_wagon = gets.to_i
  wagon = wagons[chosen_wagon]
  puts "1. Заполнить вагон. "
  puts "2. Освободить вагон. "
  puts "3. Отобразить общую вместимость, занятую и свободную."
  user_input = gets.to_i
  if user_input == 1
    if wagon.is_a? CargoWagon
      puts "Введите величину: "
      value = gets.to_i
      wagon.fill(value)
    else
      wagon.occupy
      puts "1 пассажирское сиденье занято."
    end
  elsif user_input == 2
    if wagon.is_a? CargoWagon
      puts "Введите величину: "
      value = gets.to_i
      wagon.empty(value)
    else
      wagon.unoccupy
      puts "1 пассажирское сиденье освобождено."
    end
  elsif user_input == 3
    if wagon.is_a? CargoWagon
      puts "Общая вместимость = #{wagon.volume_total}, занято = #{wagon.volume_filled}, свободно #{wagon.volume_empty}"
    else
      puts "Кол-во сидений = #{wagon.seats_total}, занято = #{wagon.occupied}, свободно = #{wagon.unoccupied}"
    end
  end
end

begin
  loop do
    puts "Доброго времени суток! Вы можете: "
    puts "1. Создать станцию. \n2. Создать поезд."
    puts "3. Создать маршрут."
    puts "4. Назначить маршрут существующим поездам."
    puts "5. Создать вагон. " 
    puts "6. Просмотреть список станций и поездов "
    puts "7. Прицепить/отцепить вагон от поезда."
    puts "8. Изменить существующие маршруты."
    puts "9. Отобразить все вагоны поезда"
    puts "10. Управление вагонами"
    puts "Для продолжения введите цифру меню, для выхода из программы введите \"Стоп\""
    user_input = gets.chomp.downcase
    create_station if user_input == "1" 
    create_train if user_input == "2" 
    create_route if user_input == "3" 
    route_assign if user_input == "4" 
    wagon_create if user_input == "5"
    stations_show if user_input == "6"
    wagon_use if user_input == "7"
    route_change if user_input == "8"
    show_wagons if user_input == "9"
    change_wagons if user_input == "10"
    break if user_input == "стоп"
  end
rescue => error
  puts error.backtrace
  puts 'Повторите ввод.'
  retry
end

exit
