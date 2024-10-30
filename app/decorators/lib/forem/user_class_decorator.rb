module Lib
  module Forem
    class UserClassDecorator
      

    end
  end
end

# Call the method if Forem.user_class is present
#Lib::Forem::UserClassDecorator.decorate_user_class! if Forem.user_class


Forem.decorate_user_class! if Forem.user_class