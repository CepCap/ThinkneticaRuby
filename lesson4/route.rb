class Route
  attr_reader :stations
  
  def initialize(departure_station, arrival_station)
    @stations = [departure_station, arrival_station]
  end

  def intermediate_station_add(station)
    @stations.insert(1, station)
  end

  def intermediate_station_delete(station)
    @stations.delete(station)
  end
end
