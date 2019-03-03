require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  attr_accessor :speed
  attr_reader :model  
  attr_reader :id    
  include InstanceCounter    
  include Manufacturer

  @@trains = {}

  def self.all
    @@trains
  end

  def initialize(model, id)
    @speed = 0
    @train_station = 0
    @model = model
    @wagons = []
    @id = id
    @@trains[model] = id # Хеш - отличное решение, не знаю поч сразу не подумал о нём.
    register_instance
  end

  def self.find_by_id(id)
    @@trains.key(id) 
  end

  def route_get(route)
    @route = route.stations
    @route[0].train_arrive(self)
  end

  def route
    @route.each { |station| print station.name + " " }
  end

  def stations
    @route[@train_station - 1] unless @route[@train_station] == @route.first
    @route[@train_station] if @route
    @route[@train_station + 1] unless @route[@train_station] == @route.last
  end

  def current_station
    @route[@train_station] if @route
  end

  def forward
    @train_station += 1 unless @route[@train_station] == @route.last  
    @route[@train_station - 1].train_depart(self)
    @route[@train_station].train_arrive(self) 
  end

  def backward
    @train_station -= 1 unless @train_station == 0
    @route[@train_station - 1].train_depart(self)
    @route[@train_station].train_arrive(self)
  end

  protected

  def unhook_wagon(wagon)   #Поместил в протектед, т.к. у каждого типа будет
    @wagons.delete(wagon)   #определен свой тип вагона.
  end

  def hook_wagon(wagon)
    @wagons << wagon
  end

end
