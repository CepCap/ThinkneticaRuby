require_relative 'instance_counter'
require_relative 'validator'

class Route
  attr_reader :stations
  include InstanceCounter
  include Validator

  validate :stations, :type, Station

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

  protected

  attr_reader :validation
end
