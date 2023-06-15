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
    redirect_to root_path, notice: "The hackathon has ended. We'll see you next time!" unless latest_event.active?
  end
   
  helper_method :latest_event 
    
  private
  
  def latest_event
    @latest_event ||= Event.latest
  end
end
