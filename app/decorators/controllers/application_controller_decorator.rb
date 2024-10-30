# ApplicationController.class_eval do
#   helper Forem::Engine.helpers
# end

# app/decorators/controllers/application_controller_decorator.rb
module Controllers
  class ApplicationControllerDecorator
    def self.decorate
      ApplicationController.class_eval do
        helper Forem::Engine.helpers
      end
    end
  end
end

# Call the decorate method
Controllers::ApplicationControllerDecorator.decorate