require_relative 'instance_counter'
require_relative 'validator'

class Station 
  attr_reader :name
  attr_reader :trains
  include InstanceCounter
  include Validator

  @@stations = []

  def initialize(name)
    @name = name.to_s
    @trains = []
    @@stations << self
    register_instance
    # @validation = [@name.length, :>, 3, "Название станции должно быть больше 3 символов"]
    # validate!(@validation)
  end

  def self.all
    @@stations
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

  def all_wagons(&block)
    @trains.each do |train|
      train.each_wagon
    end 
  end

  protected

  attr_reader :validation

end
