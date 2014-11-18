class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def verify_user_is_admin
    unless signed_in? && current_user.role == 'admin'
      if signed_in?
        begin
          flash.alert = "Permisos insuficientes"
          #TODO: Redirect to last page not working :(
          redirect_to :back
        rescue ActionController::RedirectBackError
          redirect_to root_path
        end
      else
        redirect_to :new_user_session
      end
    end
  end

end
