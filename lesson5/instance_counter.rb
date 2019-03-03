module InstanceCounter

  $instances = {}    #Не знаю, как сделать это без глобальной переменной, ибо
                     #в КлассМетодс не знают переменную класса ИнстансМетодс.

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      $instances[self.name.to_sym]
    end
  end

  private
  
  module InstanceMethods
    def register_instance
      if $instances.has_key? self.class.name.to_sym
        $instances[self.class.name.to_sym] += 1
      else
        $instances[self.class.name.to_sym] = 1
      end
    end
  end
end
