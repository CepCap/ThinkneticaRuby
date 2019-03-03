require_relative 'instance_counter'

class Route
  attr_reader :stations
  include InstanceCounter
  
  def initialize(departure_station, arrival_station)
    @stations = [departure_station, arrival_station]
    register_instance
  end

  def intermediate_station_add(station)
    @stations.insert(1, station)
  end

  def intermediate_station_delete(station)
    @stations.delete(station)
  end
end
