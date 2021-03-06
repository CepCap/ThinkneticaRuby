require_relative 'instance_counter'
require_relative 'validator'

class Station
  attr_reader :name
  attr_reader :trains
  include InstanceCounter
  include Validator

  @stations = []

  validation :name, :presence

  def initialize(name)
    @name = name.to_s
    @trains = []
    @stations << self
    register_instance
  end

  def self.all
    @stations
  end

  def train_arrive(train)
    @trains << train
  end

  def train_depart(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    @trains.find_all { |train| train.type == type }.size
  end

  def all_wagons
    @trains.each(&:each_wagon)
  end

  protected

  attr_reader :validation
end
