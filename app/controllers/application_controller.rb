class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	#デバイス機能実行前にconfigure_permitted_parametersの実行をする。

  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end
  protected
  #sign_out後のredirect先変更する。rootパスへ。rootパスはhome topを設定済み。

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    #sign_upの際にnameのデータ操作を許。追加したカラム。
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end