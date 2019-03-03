class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_arrive(train)
    @trains << train
  end

  def train_depart(train)
    @trains.delete(train) #теперь убывает не последний, а определённый поезд
  end

  def trains_list
    puts "Все поезда на станции #{@name} по номерам:"
    @trains.each {|train| print train.id.to_s + " "}
    puts
  end

  def trains_by_type
    puts "Введите тип поездов:"
    type = gets.chomp
    puts "Кол-во поездов типа #{type}: "
    puts @trains.find_all { |train| train.type == type}.size
  end
end

class Route
  attr_reader :stations
  
  def initialize(departure_station, arrival_station)
    @stations = [departure_station, arrival_station]
  end

  def intermediate_station_add(station)
    @stations.insert(1, station)
  end

  def intermediate_station_delete(station)
    @stations.delete(station) #удаляется конкретная станция
  end

  def show
    puts "Полный путь: "
    @stations.each { |station| print station.name + " "}
    puts
  end
end

class Train
  attr_accessor :speed
  attr_reader :wagon_count
  attr_reader :id               #Убрал "train" из названия, 
  attr_reader :type             #ведь и так понятно что речь идет о поезде.
  
  def initialize(id, type, wagon_count)
    @speed = 0
    @train_station = 0
    @id = id
    @type = type
    @wagon_count = wagon_count #Убрал проверку на нил.
  end

  def unhook_wagon
    if self.speed == 0
      @wagon_count -= 1
      puts "Вагон отсоединён."
    else
      puts "Нельзя отсоединить вагон в движении."
    end
  end

  def hook_wagon
    if self.speed == 0
      @wagon_count += 1
      puts "Вагон присоединён."
    else
      puts "Нельзя присоединить вагон в движении."
    end
  end

  def route_get(route)
    @route = route.stations
    @route[0].train_arrive(self)
  end

  def route
    puts "Маршрут поезда #{self.id}:"
    @route.each { |station| print station.name + " " }
    puts
  end

  def stations
    puts "Предыдущая станция: #{@route[@train_station - 1].name}" unless @route[@train_station] == @route.first
    puts "Текущая станция: #{@route[@train_station].name}" if @route
    puts "Следующая станция: #{@route[@train_station + 1].name}" unless @route[@train_station] == @route.last
  end

  def current_station
    puts "Текущая станция: #{@route[@train_station].name}" if @route
  end

  def forward
    @train_station += 1 unless @route[@train_station] == @route.last  
    @route[@train_station - 1].train_depart(self)
    @route[@train_station].train_arrive(self)  #исправил логику так, чтобы использовался
    puts "#{@route[@train_station].name}"      #метод train_arrive, а не просто движение по массиву
  end

  def backward
    @train_station -= 1 unless @train_station == 0
    @route[@train_station - 1].train_depart(self)
    @route[@train_station].train_arrive(self)
    puts "#{@route[@train_station].name}"
  end
end

mos = Station.new("Москва")
spb = Station.new("Санкт-Петербург")
rnd = Station.new("Ростов-На-Дону")
 
train1 = Train.new(10350, "Пассажирский", 37)
train2 = Train.new(23415, "Грузовой", 89)
train3 = Train.new(46364, "Пассажирский", 53)

route = Route.new(mos, rnd)

#Проверка всех методов

mos.name
mos.train_arrive(train1)
mos.trains_list
mos.trains_by_type
mos.train_depart(train1)
mos.trains_list

train1.route_get(route)
train1.route
route.intermediate_station_add(spb)
train1.route
route.intermediate_station_delete(spb)
train1.route
route.show

train1.id
train1.type
train1.wagon_count
train1.hook_wagon
train1.speed
train1.speed = 50
train1.unhook_wagon
train1.speed
train1.speed = 0
train1.unhook_wagon
train1.route_get(route)
train1.current_station
train1.forward
train1.backward
train1.stations
