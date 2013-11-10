module SessionsHelper
  def sign_in(user)
    #remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = user.remember_token
    #user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user? (user)
    @current_user == user
  end
  
  def current_user
    #remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
end
