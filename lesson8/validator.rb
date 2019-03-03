module Validator

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validation_choice

    def validate(attr, check, param = nil)
      @validation_choice ||= []
      @validation_choice << {attr: attr, type: check, param: param}
    end
  end

  module InstanceMethods
    def validate!
      self.class.validation_choice.each do |choice|
        validation_method = "#{choice[:type]}".to_sym
        send(validation_method, choice[:attr], choice[:param])
      end
      true
    end

    def valid?
      validate!
    rescue RuntimeError => e
      puts "Ошибка: #{e.inspect}"
      false
    end
  end

  protected

  def presence(attr)
    attr = instance_variable_get("@#{attr}")
    raise "Значение не может быть пустым" if attr.nil? || attr.to_s.empty?
  end

  def type(attr, type)
    attr = instance_variable_get("@#{attr}")
    raise "Неправильный тип" if attr.class != type
  end

  def format(attr, format)
    attr = instance_variable_get("@#{attr}")
    raise "Неправильный формат" if attr !~ format
  end
end
