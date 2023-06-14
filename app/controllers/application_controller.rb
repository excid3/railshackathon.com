class ApplicationController < ActionController::Base
  impersonates :user
  include Pundit
  
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_or_previous_event
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar])
  end

  def hackathon_ended
    redirect_to root_path, notice: "The hackathon has ended. We'll see you next time!" unless @current_or_previous_event.active?
  end
    
  private
  
  def set_current_or_previous_event
    @current_or_previous_event = Event.current || Event.previous
  end
end
