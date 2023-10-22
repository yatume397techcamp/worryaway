#\\wsl.localhost\Ubuntu\home\aivets\projects\worryaway\app\controllers\application_controller.rb

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def after_sign_in_path_for(resource)
    user_path(current_user)  # これはユーザーのshowアクションへのパスです
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path  # これはトップページへのパスです
  end

end
