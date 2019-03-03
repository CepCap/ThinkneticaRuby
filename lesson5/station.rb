require_relative 'instance_counter'

class Station 
  include InstanceCounter
  attr_reader :name
  attr_reader :trains

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end


  def train_arrive(train)
    @trains << train
  end

  def train_depart(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    @trains.find_all { |train| train.type == type}.size
  end
end
