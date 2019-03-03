module InstanceCounter
  $instances = {}
  # Не знаю, как сделать это без глобальной переменной, ибо
  # в КлассМетодс не знают переменную класса ИнстансМетодс.

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      $instances[name.to_sym]
    end
  end

  module InstanceMethods
    def register_instance
      if $instances.key? self.class.name.to_sym
        $instances[self.class.name.to_sym] += 1
      else
        $instances[self.class.name.to_sym] = 1
      end
    end
  end
end
