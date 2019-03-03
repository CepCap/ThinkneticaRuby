require_relative 'manufacturer'
require_relative 'validator'

class Wagon
  attr_reader :id
  include Manufacturer
  include Validator

  def initialize(id)
    @id = id
    validate!(@id.to_s.length, :>, 6, 'Номер должен быть больше 6 символов')
  end

  protected

  attr_reader :validation
end
