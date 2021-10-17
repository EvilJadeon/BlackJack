# Модули для проверки ошибок
module Validation
  def self.include(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods

  end

  module InstanceMethods
    
  end
end