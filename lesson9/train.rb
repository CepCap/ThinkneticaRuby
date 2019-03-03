require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validator'
require_relative 'accessors'

class Train
  include InstanceCounter
  include Manufacturer
  include Validator
  extend Accessors

  attr_accessor_with_history :speed
  attr_reader :model
  attr_reader :id
  attr_reader :wagons

  TRAIN_ID_FORMAT = /.{3}-?.{2}/

  @trains = {}
  validate :model, :presence
  validate :id, :format, TRAIN_ID_FORMAT

  def initialize(model, id)
    @speed = 0
    @train_station = 0
    @model = model.to_s
    @wagons = []
    @id = id.to_s
    @trains = { model.to_s => id.to_s }
    register_instance
  end

  def self.all
    @trains
  end

  def self.find_by_id(id)
    @trains.key(id)
  end

  def route_get(route)
    @route = route.stations
    @route[0].train_arrive(self)
  end

  def route
    @route.each { |station| print station.name + ' ' }
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
    @train_station -= 1 unless @train_station.zero?
    @route[@train_station - 1].train_depart(self)
    @route[@train_station].train_arrive(self)
  end

  def each_wagon
    @wagons.each { |wagon| yield(wagon) }
  end

  protected

  attr_reader :validation

  def unhook_wagon(wagon)
    @wagons.delete(wagon)
  end

  def hook_wagon(wagon)
    @wagons << wagon
  end
end
