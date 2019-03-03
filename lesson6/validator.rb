module Validator

  def valid?
    self.send :validate!, validation
  rescue
    return false
  end

  private

  def validate!(*args)
    if args[0].is_a? Array
      args.flatten!(1)
      args.each do |args|
        variable = args[0]
        checking = args[1]
        parametr = args[2]
        error_message = args[3]
        raise error_message if variable.send(checking, parametr) == nil || variable.send(checking, parametr) == false
      end
    else
    args = args.flatten
      variable = args[0]
      checking = args[1]
      parametr = args[2]
      error_message = args[3]
      raise error_message if variable.send(checking, parametr) == nil || variable.send(checking, parametr) == false
    end
  end
end
