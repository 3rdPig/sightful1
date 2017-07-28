class AppController < ApplicationController
	def index

	end

	def signUp
		if params.include?('email') && params.include?('password')
			password = params['password']
			if password == "" || password == nil
				@status = 0
				respond_to do |format|
					format.js { render 'signUp', layout: false}
				end
			else
				user = User.new(:email => params['email'], :password => password, :password_confirmation => password)
				user.first_name = params['fname']
				user.last_name = params['lname']
				f_day = 1
				t_day = 7
				ave = Availability.new
				ave.to_time = DateTime.now.change({ hour: 24, min: 0, sec: 0 })
				ave.from_time = DateTime.now.change({ hour: 00, min: 0, sec: 0 })
				ave.from_day = f_day
				ave.to_day = t_day
				user.availabilities << ave
				user.save!
				sign_in(:user, user)
				redirect_to '/mentors'
			end
		end
	end

	def signUpMentor
		if params.include?('email') && params.include?('password')
			password = params['password']
			if password == "" || password == nil
				@status = 0
				respond_to do |format|
  					format.js { render 'signUp', layout: false}
  				end
			else
				user = User.new(:email => params['email'], :password => password, :password_confirmation => password)
				user.first_name = params['fname']
				user.last_name = params['lname']
				user.mentor = 1
				f_day = 1
		        t_day = 7
		        ave = Availability.new
		        ave.to_time = DateTime.now.change({ hour: 24, min: 0, sec: 0 })
		        ave.from_time = DateTime.now.change({ hour: 00, min: 0, sec: 0 })
		        ave.from_day = f_day
		        ave.to_day = t_day
		        user.availabilities << ave
				user.save!
				sign_in(:user, user)
				redirect_to '/profile'
			end
		end
	end

	def login
		if params.include?('email') && params.include?('password')
			user = User.find_by_email(params['email'])
			 pwd = params['password']
			 if user.valid_password?(pwd)
				if user.present? && user.mentor?
					sign_in(:user, user)
				 	redirect_to '/invites'
				else
					sign_in(:user, user)
				 	redirect_to '/mentors'
				end
			 end

		end
	end

	def home
		@user = current_user
		@mentors = User.where(mentor:true)
	end

	def profile
		@user = current_user
	end

	def logout
		sign_out()
		redirect_to root_path
	end

	def googleAuth
		user_info = request.env["omniauth.auth"]
		email =  user_info["info"]["email"]

		user = User.find_by_email(email)
		if !user.present?
			user = User.new
			puts(user_info["info"])
			user.email = user_info["info"]["email"]
			user.first_name = user_info["info"]["name"]
			user.dp = user_info["info"]["image"]
			user.auth = user_info['credentials']['token']
			password = Devise.friendly_token.first(8)
			user.password = password
			user.password_confirmation = password
			f_day = 1
			t_day = 7
			ave = Availability.new
			ave.to_time = DateTime.now.change({ hour: 24, min: 0, sec: 0 })
			ave.from_time = DateTime.now.change({ hour: 00, min: 0, sec: 0 })
			ave.from_day = f_day
			ave.to_day = t_day
			user.availabilities << ave
			user.save!
		end
		sign_in(:user, user)
		redirect_to '/mentors'
	end

	def updateProfile
		fname  = params['fname']
		lname = params['lname']
		headline = params['headline']
		phone = params['phone']
		zip = params['zip']
		location = params['location']
		ccompany = params['current_company']
		ctitle = params['current_title']
		ptitle = params['prev_title']
		pcompany = params['prev_company']
		gschool = params['grad_school']
		gmajor = params['grad_major']
		uschool = params['undergrad_school']
		umajor = params['undergrad_major']

		user  = current_user
		user.first_name = fname
		user.last_name = lname
		user.headline = headline
		user.zip  = zip
		user.phone = phone
		user.location = location
		user.current_company = ccompany
		user.current_title = ctitle
		user.prev_company = pcompany
		user.prev_title = ptitle
		user.grad_major = gmajor
		user.grad_school = gschool
		user.undergrad_school = uschool
		user.undergrad_major = umajor
		user.save
		@status = 1
		respond_to do |format|
			format.js { render 'updateProfile', layout: false}
		end
	end

	def schedule
		@user = current_user
		if @user.nil?
			redirect_to root_path
		end
		if params.include?('id')
		 	id = params['id'].to_i
		 	if User.exists?(id)
		 		user  = User.find(id)
		 		@user = user
		 	end
		 end
	end

	#def requests
	#	@user = current_user
	#	if @user.nil?
	#		redirect_to root_path
	#	end
	#	if params.include?('id')
	#	 	id = params['id'].to_i
	#	 	if User.exists?(id)
	#	 		user  = User.find(id)
	#	 		@user = user
	#	 	end
	#	 end
	#end

	def requests
		@user = current_user
		sch = Schedule.where(inviter:current_user['id'])
		@invites = sch

	end #end def invites

	def invites
		@user = current_user
		sch = Schedule.where(invitee:current_user['id'])
		@invites = sch

	end #end def invites
end
