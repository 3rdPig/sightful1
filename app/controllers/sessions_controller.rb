class SessionsController < ApplicationController
  include HTTParty
  base_uri 'http://localhost:3000/api'
  
  # def new
  # end
  
  # def basic_login
  #   # @user = User.find_by_email(params[:email])
  #   # if @user && @user.authenticate(params[:password])
  #
  #   # Third party account has no password
  #   if params[:password].nil? || params[:password]==""
  #     flash[:danger] = "Email or Password is invalid"
  #     redirect_to "#" and return
  #   end
  #
  #   msg = self.class.post('/sign_in', {query: params})
  #   msg = msg.parsed_response
  #   if msg["status"] == 1
  #     session[:user_id] = msg["user"]["id"]
  #     flash[:success] = "Logged In!"
  #     redirect_to "#"
  #   else
  #     flash[:danger] = "Email or Password is invalid"
  #     redirect_to "#"
  #   end
  # end
  
  # def destroy
  #   session[:return_to] ||= request.referer
  #   session[:user_id] = nil
  #   flash[:info] = "Logged Out!"
  #   redirect_to session.delete(:return_to)
  # end
  
  def auth_failure
    flash[:danger] = "Third Party Authentication Failed."
    redirect_to root_path
  end
  
  def linkedInLogin
    # TODO: handle different provider by params[:provider]
    
    userInfo = env['omniauth.auth']['info']
    userRawInfo = env['omniauth.auth']['extra']['raw_info']
    userCredentials = env['omniauth.auth']['credentials']

    user_data = Hash.new
    ignore_exception { user_data['company'] = userRawInfo['positions']['values'][0]['company']['name'] }
    ignore_exception { user_data['f_name'] = userInfo['first_name'] }
    ignore_exception { user_data['l_name'] = userInfo['last_name'] }
    ignore_exception { user_data['email'] = userInfo['email'] }
    ignore_exception { user_data['token'] = userCredentials['token'] }
    ignore_exception { user_data['location'] = userInfo['location']['name'] }
    ignore_exception { user_data['desig'] = userRawInfo['positions']['values'][0]['title'] }

    user = User.find_by_email(user_data['email'])
    unless user.present?
      user = User.new
      user.email = user_data['email']
      user.first_name= user_data['f_name']
      user.last_name= user_data['l_name']
      user.mentor = true
      user.save
      work = Work.new
      work.company = user_data['company']
      work.designation = user_data['desig']
      work.city = user_data['location']
      work.country = ''
      work.save
      user.works << work
      f_day = 1
      t_day = 7
      ave = Availability.new
      ave.to_time = DateTime.now.change({ hour: 20, min: 0, sec: 0 })
      ave.from_time = DateTime.now.change({ hour: 18, min: 0, sec: 0 })
      ave.from_day = f_day
      ave.to_day = t_day
      user.availabilities << ave
      user.save
    end
    # devise handles sign_in
    sign_in(:user, user)
    flash[:success] = "Logged In!"
    redirect_to root_path
    
  end

  # def google_login
  #   byebug
  #   userInfo = env['omniauth.auth']['info']
  #   userRawInfo = env['omniauth.auth']['extra']['raw_info']
  #   userCredentials = env['omniauth.auth']['credentials']
  #
  #   user_data = Hash.new
  #   ignore_exception { user_data['f_name'] = userInfo['first_name'] }
  #   ignore_exception { user_data['l_name'] = userInfo['last_name'] }
  #   ignore_exception { user_data['email'] = userInfo['email'] }
  #   ignore_exception { user_data['token'] = userCredentials['token'] }
  #   ignore_exception { user_data['auth'] = "google" }
  #
  #   msg = self.class.post('/signUp_google', { query: user_data })
  #   msg = msg.parsed_response
  #   if msg["status"] == 1
  #     session[:user_id] = msg["user"]
  #     flash[:success] = "Logged In!"
  #     redirect_to "/"
  #   else
  #     flash[:danger] = "Seems Impossible to Get Here lol"
  #     redirect_to "/"
  #   end
  #
  # end
  
  private
  def session_params
    params.require(:sessions).permit()
  end
end
