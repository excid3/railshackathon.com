class ApplicationController < ActionController::Base
  impersonates :user
  include Pundit

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar])
    end

    def hackathon_ended
      redirect_to teams_path, notice: "The hackathon has ended. We'll see you next year!"
    end
end
