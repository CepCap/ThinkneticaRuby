module Accessors

  def attr_accessor_with_history(*attrs)
    attrs.each do |attr|
      instance_variable_set(:@history, nil)
      define_method(attr.to_sym) { "@#{attr}".to_sym }
      define_method("#{attr}=".to_sym) do |var|
        instance_var = "@#{attr}".to_sym
        instance_var = var
        @history.is_a?(Array) ? @history << var : @history = [var]
      end
      define_method("#{attr}_history".to_sym) { @history }

    end
  end

  def strong_attr_accessor(attr, attr_class)
      define_method(attr.to_sym) { "@#{attr}" }
      define_method("#{attr}=".to_sym) do |var|
        raise "Тип не соответствует" if var.class != attr_class
        instance_var = "@#{attr}".to_sym
        instance_var = var
      end
  end
end
