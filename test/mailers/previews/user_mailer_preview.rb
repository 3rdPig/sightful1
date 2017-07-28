# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/signup_confirmation
  def signup_confirmation
    @user = {"email" => "yenfengc@uci.edu"} # email: "yenfengc@uci.edu" does NOT work
    UserMailer.signup_confirmation(@user)
  end

end
