module Accessors

  def attr_accessor_with_history(*attrs)
    attrs.each do |attr|
      class_eval %{
        @#{attr}_history
        def #{attr}
          @#{attr}
        end

        def #{attr}= var
          @#{attr} = var
          @#{attr}_history.is_a?(Array) ? @#{attr}_history << var : @#{attr}_history = [var]
        end

        def #{attr}_history
          @#{attr}_history
        end
      }
    end
  end

  def strong_attr_accessor(attr, attr_class)
    class_eval %{
      def #{attr}
        @#{attr}
      end

      def #{attr}= var
        raise "Тип не соответствует" if attr.class != attr_class
        @#{attr}= var
      end
    }
  end
end
