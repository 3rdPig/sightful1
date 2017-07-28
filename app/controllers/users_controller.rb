class UsersController < ApplicationController
  include HTTParty
  base_uri 'http://localhost:3000/api'
  
  # def new
  #   @user = User.new
  # end
  #
  # def basic_signup
  #
  #   msg = self.class.post('/signUp_mentee', {query: params})
  #   msg = msg.parsed_response
  #   byebug
  #   if msg['status'] == 1
  #     flash[:success] = 'New user created. Please verify email before proceeding.'
  #     @user = User.find_by_email(params['email'])
  #     UserMailer.signup_confirmation(@user).deliver_later # using activejob, need to revise since it is not persistent
  #     redirect_to root_url
  #   else
  #     flash[:danger] = 'Something Wrong'
  #     redirect_to root_url
  #   end
  # end
  
  def confirm_email
    byebug
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Your email has been confirmed. Please sign in to continue."
      redirect_to root_url
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
  end
  
  private
  def user_params
    params.require(:users).permit()
  end
end
