module SessionsHelper

  def sign_in(user)
  	
    #cookies.permanent[:remember_token] = user.remember_token
    session[:email] = user.email.downcase
		session[:password] = user.password_digest
    self.current_user = user
  end
  
  def remember_email(user)
  	cookies.permanent[:remember_email] = user.email.downcase
  end
  
  def signed_in?
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil
    #cookies.delete(:remember_token)
    session.delete(:email)
    session.delete(:password)
    cookies.delete(:remember_email)
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
  
    #@current_user ||= User.find_by_remember_token(cookies[:remember_token])
    #@current_user ||= User.find_by_email(session[:email])
    
=begin    
		if @current_user.nil?
			@current_user = User.find_by_email(session[:email])
		else
			@current_user
		end
		
		if @current_user.nil? && !cookies[:remember_email].nil?
			@current_user = User.find_by_email(cookies[:remember_email])
		else
			@current_user
		end
=end		
		#=============================
		email = !cookies[:remember_email].nil? ? cookies[:remember_email]: session[:email]
		@current_user ||= User.find_by_email(email)				
		#=============================
=begin		
		if @current_user.nil?
			if !cookies[:remember_email].nil?
				@current_user = User.find_by_email(cookies[:remember_email])
			else
				@current_user = User.find_by_email(session[:email])
			end
		end
		@current_user
=end
				
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

end
