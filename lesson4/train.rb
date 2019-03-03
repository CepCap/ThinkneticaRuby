class Train
  attr_accessor :speed
  attr_reader :model          
  
  def initialize(model)
    @speed = 0
    @train_station = 0
    @model = model
    @wagons = []
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
