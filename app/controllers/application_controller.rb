class ApplicationController < ActionController::Base
	before_action :configure_devise_permitted_params, if: :devise_controller?
	before_action :clear_search_session_vals, if: ->{ action_name == "index" }

	protected

  def configure_devise_permitted_params
   devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password])
  end

  private

  def clear_search_session_vals
  	session.delete(:categories)
    session.delete(:ratings)
  end
end
