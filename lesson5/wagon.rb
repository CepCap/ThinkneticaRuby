require_relative 'manufacturer'

class Wagon
  attr_reader :id
  include Manufacturer

  def initialize(id)
    @id = id
  end
end
