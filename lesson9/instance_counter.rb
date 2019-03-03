module InstanceCounter
  @@instances = {}

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @@instances[name.to_sym]
    end
  end

  module InstanceMethods
    def register_instance
      @@instances[self.class.name.to_sym] ||= 0
      @@instances[self.class.name.to_sym] += 1
    end
  end
end
