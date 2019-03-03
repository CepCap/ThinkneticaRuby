require_relative 'instance_counter'
require_relative 'validator'

class Route
  attr_reader :stations
  include InstanceCounter
  include Validator

  def initialize(departure_station, arrival_station)
    @stations = [departure_station, arrival_station]
    register_instance
    validate!(@stations[0], :is_a?, Station, 'Путь должен состоять из станций')
    validate!(@stations[1], :is_a?, Station, 'Путь должен состоять из станций')
  end

  def intermediate_station_add(station)
    @stations.insert(1, station)
  end

  def intermediate_station_delete(station)
    @stations.delete(station)
  end

  protected

  attr_reader :validation
end
