class ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  require 'tod'
  def signUp_mentor
    msg = {status:2,msg:'Failed'}
    if params.include?('password') && params.include?('email') && params.include?('phone') && params.include?('field')
      user = User.new
      user.email = params['email']
      user.pwd= params['password']
      user.phone= params['phone']
      user.mentor = true
      field = Field.new
      field.field = params['field']
      user.fields << field
      user.save
      msg = {status:1,msg:'Success',user:user}
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end
  def signUp_google
    msg = {status:2,msg:'Failed'}
    if params.include?('auth') && params.include?('email') && params.include?('f_name') && params.include?('l_name') && params.include?('token')
      user = User.find_by_email(params['email'])
      if user.present?
        msg = {status:1,msg:'Success',user:user.id,new:0}
      else
        user = User.new
        user.email = params['email']
        user.auth= params['auth']
        user.first_name= params['f_name']
        user.last_name= params['l_name']
        user.mentor = true
        user.save
        f_day = 1
        t_day = 7
        ave = Availability.new
        ave.to_time = DateTime.now.change({ hour: 20, min: 0, sec: 0 })
        ave.from_time = DateTime.now.change({ hour: 18, min: 0, sec: 0 })
        ave.from_day = f_day
        ave.to_day = t_day
        user.availabilities << ave
        msg = {status:1,msg:'Success',user:user.id,new:1}
      end
      user.firtoken = params['token']
      user.save
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end
  def signUp_linkedin
    msg = {status:2,msg:'Failed'}
    if params.include?('email') && params.include?('f_name') && params.include?('l_name') && params.include?('token') && params.include?('location')
      user = User.find_by_email(params['email'])
      if user.present?
        msg = {status:1,msg:'Success',user:user.id,new:0}
      else
        user = User.new
        user.email = params['email']
        user.first_name= params['f_name']
        user.last_name= params['l_name']
        user.mentor = true
        user.save
        work = Work.new
        work.company = params['company']
        work.designation = params['desig']
        work.city = params['location']
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
        msg = {status:1,msg:'Success',user:user.id,new:1}
      end
      user.firtoken = params['token']
      user.save
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end
  def add_fields
    msg = {status:2,msg:'Failed'}
    if params.include?('id') && params.include?('field') && params.include?('mentor')
      mentor = params['mentor'].to_i
      id = params['id'].to_i
      msg = {status:3,msg:'Failed'}
      if User.exists?(id)
        user = User.find(id)
        if mentor == 1
          user.mentor = true
        else
          user.mentor = false
        end
        field = Field.new
        field.field = params['field']
        user.fields << field
        user.save
        msg = {status:1,msg:'Success'}
      end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end

  def signUp_mentee
    msg = {status:2,msg:'Failed'}
    if params.include?('password') && params.include?('email') && params.include?('phone')
      # what if user sign up with the existing email? should return user existed
      # handle this in api or in controller?
      user = User.new
      user.email = params['email']
      user.pwd= params['password']
      user.phone= params['phone']
      user.mentor = false
      user.save
      msg = {status:1,msg:'Success',user:user}
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end
  def add_work
    msg = {status:2,msg:'Failed'}
    if params.include?('id') && params.include?('company') && params.include?('desig') && params.include?('country') && params.include?('city')

      msg = {status:3,msg:'Failed'}
      id = params['id'].to_i
      if User.exists?(id)
        user = User.find(id)
        work = Work.new
        work.company = params['company']
        work.designation = params['desig']
        work.country = params['country']
        work.city = params['city']
        work.save
        user.works << work
        user.save
        msg = {status:1,msg:'Success'}
      end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end
  def add_work_mentor
    msg = {status:2,msg:'Failed'}
    if params.include?('id') && params.include?('company') && params.include?('desig') && params.include?('country') && params.include?('city')

      msg = {status:3,msg:'Failed'}
      id = params['id'].to_i
      if User.exists?(id)
        user = User.find(id)
        work = Work.new
        work.company = params['company']
        work.designation = params['desig']
        work.country = params['country']
        work.city = params['city']
        work.save
        user.works << work
        user.save
        msg = {status:1,msg:'Success'}
      end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end
  def add_education
    msg = {status:2,msg:'Failed'}
    if params.include?('id') && params.include?('degree') && params.include?('uni') && params.include?('year_c')
      id = params['id'].to_i
      if User.exists?(id)

        user = User.find(id)
        edu = Education.new
        edu.year_completion= params['year_c']
        edu.unversity = params['uni']
        edu.degree = params['degree']
        user.educations << edu
        msg = {status:1,msg:'Success'}
      end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end
  def sign_in
    msg = {status:2,msg:'Failed'}
    if params.include?('email') && params.include?('password')
      msg = {status:3,msg:'Failed'}
      email = params['email']
      password = params['password']
      user = User.find_by_email(email)
      if user.present?
        msg = {status:4,msg:'Failed'}
        if user.pwd == params['password']
          msg = {status:1,msg:'Success',user:user}
        end
      end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end
  def follow
    msg = {status:2,msg:'Failed'}
    if params.include?('id') && params.include?('follower_id')
      id1 = params['id'].to_i
      id2 = params['follower_id'].to_i
      msg = {status:3,msg:'Failed'}
      if User.exists?(id1) && User.exists?(id2)
        user1 = User.find(id1)
        user2 = User.find(id2)
        user1.followers << user2
        user1.save
        user2.save
        notify(user1.firtoken,"1 user started following you" , "1 user started following you")
        msg = {status:1,msg:'Success'}
      end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end
  def get_followers
    msg = {status:2,msg:'Failed'}
    if params.include?('id')
      msg = {status:3,msg:'Failed'}
      id = params['id'].to_i
      if User.exists?(id)
        user = User.find(id)
        followers = user.followers
        msg = {status:1,msg:'Success',followers:followers}
      end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end
  def get_followees
    msg = {status:2,msg:'Failed'}
    if params.include?('id')
      msg = {status:3,msg:'Failed'}
      id = params['id'].to_i
      if User.exists?(id)
        user = User.find(id)
        followees = user.followees
        msg = {status:1,msg:'Success',followees:followees}
      end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end
  def delete_follower
    msg = {status:2,msg:'Failed'}
    if params.include?('follower_id') && params.include?('followee_id')
      id1 = params['follower_id'].to_i
      id2 = params['followee_id'].to_i
      msg = {status:3,msg:'Failed'}
      if User.exists?(id1) && User.exists?(id2)
        user1 = User.find(id1)
        user2 = User.find(id2)
        if user2.followers.exists?(id1)
          user2.followers.delete(user1)
          user1.save
          user2.save
        end
        msg = {status:1,msg:'Success'}
      end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end
  def set_available
    msg = {status:2,msg:'Failed'}
    if params.include?('id') && params.include?('f_day') && params.include?('t_day') && params.include?('f_time') && params.include?('t_time')
      msg = {status:3,msg:'Failed'}
      id = params['id'].to_i
      if User.exists?(id)
        user = User.find(id)
        f_day = params['f_day'].to_i
        t_day = params['t_day'].to_i
        f_time = params['f_time']
        t_time = params['t_time']
        f_time_s = Tod::TimeOfDay.parse(f_time).to_s
        t_time_s = Tod::TimeOfDay.parse(t_time).to_s
        ave = Availability.new
        ave.to_time = t_time_s
        ave.from_time = f_time_s
        ave.from_day = f_day
        ave.to_day = t_day
        user.availabilities << ave
        user.save
        msg = {status:1,msg:'Success'}
      end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end
  def set_available_time
    msg = {status:2,msg:'Failed'}
    if params.include?('id') && params.include?('f_time') && params.include?('t_time')
      msg = {status:3,msg:'Failed'}
      id = params['id'].to_i
      if User.exists?(id)
        user = User.find(id)
        f_day = 1
        t_day = 7
        f_time = params['f_time']
        t_time = params['t_time']
        f_time_s = DateTime.strptime(f_time, '%Y-%m-%d %H:%M:%S')
        t_time_s = DateTime.strptime(t_time, '%Y-%m-%d %H:%M:%S')
        ave = Availability.new
        ave.to_time = t_time_s.utc
        ave.from_time = f_time_s.utc
        ave.from_day = f_day
        ave.to_day = t_day
        user.availabilities << ave
        user.save
        msg = {status:1,msg:'Success'}
      end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end
  def get_available
    msg = {status:2,msg:'Failed'}
    if params.include?('id')
      msg = {status:3,msg:'Failed'}
      id = params['id'].to_i
      if User.exists?(id)
        user = User.find(id)
        aves = user.availabilities.last
        from = aves.from_time
        to = aves.to_time
        tod1 = Tod::TimeOfDay.parse(from)
        tod2 = Tod::TimeOfDay.parse(to)
        times = []
        while tod1 < tod2 do
        	times << tod1.to_s
        	tod1 = tod1+(60*30)
        end
        msg = {status:1,msg:'Success',times:times}
      end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end
  def get_available_date
    if params.include?('id') && params.include?('date')
      msg = {status:3,msg:'Failed'}
      id = params['id'].to_i
      if User.exists?(id)
        user = User.find(id)
        aves = user.availabilities.last
        from = aves.from_time.to_time
        to = aves.to_time.to_time
        t_f = from.strftime("%I:%M%p")
        t_t =  to.strftime("%I:%M%p")
        tod1 = Tod::TimeOfDay.parse(t_f)
        tod2 = Tod::TimeOfDay.parse(t_t)
        times = []
        while tod1 < tod2 do
        	times << from
        	tod1 = tod1+(60*30)
          from = from + 60*30
        end
        date = Date.parse(params['date'])
        schedules = user.schedules.where(dt: date.midnight..date.end_of_day )
        schedules.each do |s|
        	times.each do |t|
        		#t = Tod::TimeOfDay.parse(t)
        		if t.hour == s.dt.hour && t.min == s.dt.min
        			times.delete(t.to_s)
        		end
        	end
        end
      	msg = {status:1,msg:'Success',times:times}
     end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end
  def set_profile
    msg = {status:2,msg:'Failed'}
    if params.include?('id') && params.include?('f_name') && params.include?('l_name')
      id = params['id'].to_i
      msg = {status:3,msg:'Failed'}
      if User.exists?(id)
        user = User.find(id)
        user.first_name = params['f_name']
        user.last_name = params['l_name']
        user.save
        msg = {status:1,msg:'Success'}
      end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end
  def get_profile
    msg = {status:2,msg:'Failed'}
    if params.include?('id')
      id = params['id'].to_i
      msg = {status:3,msg:'Failed'}
      if User.exists?(id)
        user = User.find(id)

        aves = user.availabilities.last
        from = aves.from_time

        to = aves.to_time

#        fromdate_s = from.strftime("%I:%M%p")
#        todate_s = from.strftime("%I:%M%p")

#       tod1 = Tod::TimeOfDay.parse(from)
#       tod2 = Tod::TimeOfDay.parse(to)
        tod1 = from.to_time
        tod2 = to.to_time

        edu = user.educations.last
        works = user.works
        work = user.works.first

        user = user.as_json
        user.delete('password')
        user.delete('auth')
        user.delete('phone')

        if work!=nil
         user = user.merge({designation: work.designation})
         user = user.merge({company: work.company})
         user = user.merge({country: work.country})
         user = user.merge({city: work.city})
        else
         user = user.merge({designation: ''})
         user = user.merge({company: ''})
         user = user.merge({country: ''})
         user = user.merge({city: ''})
        end

        user = user.as_json
        ws = []
        works.each do |w|
          ws << w.company
        end
        user = user.merge({works:ws})
        if edu != nil
         user = user.merge({uni:edu.unversity})
         user =  user.merge({degree:edu.degree})
         user =  user.merge({degree_year:edu.year_completion})
        else
         user =  user.merge({uni:''})
         user =  user.merge({degree:''})
         user =  user.merge({degree_year:''})
        end

        user = user.merge({time_from:tod1})
        user = user.merge({time_to:tod2})

        msg = {status:1,msg:'Success',user:user}
      end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end
  def get_mentors
    msg = {status:2,msg:'Failed'}
    if params.include?('field')
      users = []
      f = params['field']

      User.all.each do |user|
        field = user.fields.last
        if user.mentor == true
          work = user.works.first
          user = user.as_json
          user.delete('password')
          user.delete('auth')
          user.delete('phone')

          if work!=nil
            user = user.merge({designation: work.designation})
            user = user.merge({company: work.company})
            user = user.merge({country: work.country})
            user = user.merge({city: work.city})
          else
            user = user.merge({designation: ''})
            user = user.merge({company: ''})
            user = user.merge({country: ''})
            user = user.merge({city: ''})
          end

          users << user
        end
      end
      msg = {status:1,msg:'Success',users:users}
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end
  def get_mentees
    msg = {status:2,msg:'Failed'}
    if params.include?('field')
      users = []
      f = params['field']
      fields = Field.where(field:f)
      fields.each do |f|
        user = f.user
        if user.mentor == false
          user = user.as_json
          user.delete('password')
          user.delete('auth')
          user.delete('phone')
          users << user
        end
      end
      msg = {status:1,msg:'Success',users:users}
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end
  def post
    msg = {status:'2'}
    if params.include?("user_id") && params.include?("userfile")
      id = params['user_id']
      if User.exists?(id.to_i)
        user = User.find(id.to_i)
        msg = {status:'1'}
        name = Time.now.utc.to_i.to_s+".png"
        directory = "public/images"
        path = File.join(directory, name)
        File.open(path, "wb") { |f| f.write(params['userfile'].read) }
        obj = S3_BUCKET.object(name)
        # Upload the file
        obj.upload_file(path, acl:'public-read')
        #obj.write(
        #    file: params['userfile'],
        #    acl: :public_read
        #)
        user.dp = obj.public_url
        user.save
      end
    end
    respond_to do |format|
      format.json { render json: msg } # don't do msg.to_json
    end
  end
  def get_mentors_user
    msg = {status:'2'}
    if params.include?('id')
      id = params['id'].to_i
      msg = {status:'3'}
      if User.exists?(id)
        user = User.find(id)
        fld = user.fields.last
        msg = {status:'4'}
        users = []
        if fld!=nil
          msg = {status:'5'}
          f = fld.field
          User.all.each do |user|
            field = user.fields.last
            if field!=nil && field.field == f && user.mentor == true && user.id!=id
              wrks = user.works
              edu = user.educations.last
              work = user.works.first
              user = user.as_json
              user.delete('password')
              user.delete('auth')
              user.delete('phone')
              if work!=nil
                user = user.merge({designation: work.designation})
                user = user.merge({company: work.company})
                user = user.merge({country: work.country})
                user = user.merge({city: work.city})
              else
                user = user.merge({designation: ''})
                user = user.merge({company: ''})
                user = user.merge({country: ''})
                user = user.merge({city: ''})
              end
              companies = []
              wrks.each do |w|
                companies << w.company
              end
              user = user.merge({comapnies:companies})
              if edu != nil
               user = user.merge({uni:edu.unversity})
               user =  user.merge({degree:edu.degree})
               user =  user.merge({degree_year:edu.year_completion})
              else
               user =  user.merge({uni:''})
               user =  user.merge({degree:''})
               user =  user.merge({degree_year:''})
              end
              users << user
            end
          end
          msg = {status:1,users:users}
        end
      end
    end
    respond_to do |format|
      format.json { render json: msg } # don't do msg.to_json
    end
  end
  def add_invitation
  	msg = {status:2,msg:'Failed'}
    if params.include?('from') && params.include?('to') && params.include?('time') && params.include?('date') && params.include?('ref')
      from = params['from'].to_i
      to = params['to'].to_i
      msg = {status:3,msg:'Failed'}
      if User.exists?(from) && User.exists?(to)
      	sche = Schedule.new
      	dt = DateTime.parse(params['date'])
      	time = Tod::TimeOfDay.parse(params['time'])
      	dt = dt.change({hour:time.hour,min:time.minute,sec:time.second})

      	sche.dt = dt.utc
      	user_to = User.find(to)
      	user_from = User.find(from)
        topic_ref = Message.where(ref: params['ref'])
      	sche.host_id = from
        sche.ref = topic_ref[0]
        sche.status = 1
        sche.inviter = user_from
        sche.invitee = user_to
      	sche.save!

      	user_to.invitations<<sche
      	user_to.save
        notify(user_to.firtoken,"1 New invitation" , "1 New invitation")
      	msg = {status:1,msg:'Success'}
      end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end

  def add_invitation_topic
  	msg = {status:2,msg:'Failed'}
    if params.include?('from') && params.include?('to') && params.include?('topic') && params.include?('ref')
      from = params['from'].to_i
      to = params['to'].to_i
      msg = {status:3,msg:'Failed'}
      if User.exists?(from) && User.exists?(to)
        topic = Message.new

        topic.content = params['topic']
        topic.ref = params['ref'].to_i
        topic.mentor = 0
        topic.save

      	msg = {status:1,msg:'Success'}
      end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end

  def get_notifications
  	msg = {status:2,msg:'Failed'}
  	if params.include?('id')
  		id = params['id'].to_i
  		if User.exists?(id)
  			user = User.find(id)
  			invitations = user.invitations
  			invites = []
  			invitations.each do |i|
  				host = i.host
  				i = i.as_json
  				host = host.as_json
  				if host!=nil
  					host.delete('email')
  					host.delete('password')
  					host.delete('auth')
  				end
  				i.delete('invitee')
  				i = i.merge({'host':host})
  				invites << i
  			end
        invites.reverse!
  			msg = {status:1,msg:'Success',invites:invites}
  		end
  	end
    respond_to do |format|
      format.json {render json: msg}
    end
  end

  def respond_invite_old
    msg = {status:2,msg:'Failed'}
    if params.include?('id') && params.include?('invite_id') && params.include?('resp')
      id = params['id'].to_i
      invite_id = params['invite_id'].to_i
      resp = params['resp'].to_i
      msg = {status:3,msg:'Failed'}
      if User.exists?(id)
        user = User.find(id)
        msg = {status:4,msg:'Failed'}
        if user.invitations.exists?(invite_id)
          if resp == 1
            invite = user.invitations.find(invite_id)
            sch1 = Schedule.new
            sch1.dt = invite.dt
            sch1.host = user
            host = invite.host
            host.schedules << sch1
            host.save
            notify(invite.host.firtoken,user.first_name+" accepted your invitation" , user.first_name+" accepted your invitation")
            user.schedules << invite
            user.invitations.delete(invite_id)
            user.save
            msg = {status:1,msg:'Success'}
          else
            user.invitations.delete(invite_id)
            user.save
            msg = {status:1,msg:'Success'}
          end
        end
      end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end

  def schedules
  	msg = {status:2,msg:'Failed'}
	  if params.include?('id')
		  id = params['id'].to_i
  		msg = {status:3,msg:'Failed'}
		  if User.exists?(id)
			  user = User.find(id)
			  #dt = DateTime.current
			  #dt = (dt.to_time-30.minutes).to_datetime
			  #sch_today = user.schedules.where(dt: dt..Date.today.end_of_day)
        #sch_today = user.schedules.all
        sch = Schedule.where(status: 1, invitee:user['id'])
        #sch = Schedule.where(status: 1, host_id:user['id'])
        msg = {status:1, data:sch, msg:'Success'}
        respond_to do |format|
          format.json {render json: msg}
        end
		  end #if User.exists?(id)
	  end #if params.include?('id')
  end #end def schedules

  def is_follower
    msg = {status:2,msg:'Failed'}
    if params.include?('id') && params.include?('id2')
      id1  = params['id'].to_i
      id2 = params['id2'].to_i
      msg = {status:3,msg:'Failed'}
      if User.exists?(id1) && User.exists?(id2)
        user1 = User.find(id1)
        count = user1.followers.where(id:id2).count
        if(count > 0)
          msg = {status:1,count:1,msg:'Success'}
        else
          msg = {status:1,count:0,msg:'Success'}
        end
      end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end

  def unfollow
  	msg = {status:2,msg:'Failed'}
  	if params.include?('id') && params.include?('follower_id')
  		id1 = params['id'].to_i
  		id2 = params['follower_id'].to_i
  		msg = {status:3,msg:'Failed'}
  		if User.exists?(id1) && User.exists?(id2)
  			user = User.find(id1)
  			if user.followers.exists?(id2)
  				user.followers.delete(id2)
  				user.save
  			end
  			msg = {status:1,msg:'Success'}
  		end
  	end
    respond_to do |format|
      format.json {render json: msg}
    end
  end

  def post_objective
    msg  = {status:2,msg:'Failed'}
    if params.include?('user_id') && params.include?('desc')
        id = params['user_id'].to_i
        msg  = {status:3,msg:'Failed'}
        if(User.exists?(id))
          user = User.find(id)
          post = Post.new
          post.desc = params['desc'];
          post.save
          user.posts << post
          user.save
          msg = {status:1,msg:'Success', post_id:post.id}
        end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end

  def get_objectives
    msg  = {status:2,msg:'Failed'}
    if params.include?('user_id')
      id = params['user_id'].to_i
      msg  = {status:3,msg:'Failed'}
      if User.exists?(id)
        user = User.find(id)
        posts_json = []
        posts = Post.order('id desc').limit(100)
        posts.each do |post|
          if post.user.followers.exists?(user.id)
            count = post.comments.count
            u = post.user
            u  = u.as_json
            u.delete('email')
            u.delete('password')
            u.delete('auth')
            p = post.as_json
            p = p.merge({'comments':count})
            p = p.merge({'user':u})
            posts_json << p
          end
        end
        msg  = {status:1,posts:posts_json};
      end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end

  def post_comment
    msg  = {status:2,msg:'Failed'}
    if params.include?('user_id') && params.include?('post_id') && params.include?('desc')
      msg  = {status:3,msg:'Failed'}
      user_id = params['user_id'].to_i
      post_id = params['post_id'].to_i
      if User.exists?(user_id)
        msg  = {status:4,msg:'Failed'}
        if Post.exists?(post_id)
          user  = User.find(user_id)
          post = Post.find(post_id)
          comment = Comment.new
          comment.desc = params['desc']
          comment.save
          user.comments << comment
          user.save
          post.comments << comment
          post.save
          comment_id = comment.id
          c = comment.as_json
          u = user.as_json
          u.delete('email')
          u.delete('password')
          u.delete('auth')
          c = c.merge({'user':u})
          msg  = {status:1,msg:'Success',comment:c}
        end
      end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end

  def get_comments
    msg  = {status:2,msg:'Failed'}
    if params.include?('post_id')
      id  = params['post_id'].to_i
      msg  = {status:3,msg:'Failed'}
      if Post.exists?(id)
        post = Post.find(id)
        comments = post.comments
        comments_json = []
        comments.each do |c|
          user = c.user
          user = user.as_json
          user.delete('email')
          user.delete('password')
          user.delete('auth')
          c = c.as_json
          c = c.merge({'user':user})
          comments_json << c
        end
        msg  = {status:1,msg:'Success',comments:comments_json}
      end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end

  def notify(token, title, body)
    ids = []
    ids << token
    fcm = FCM.new("AAAAzDy_4FM:APA91bGXE9W9Qjj3Ah6aVAC7epVCyxrHqD0McYfSxmfrq5JOPl6DR3hgKU5gz_JHhkojopRNZPDLcyGNcalufuC5zMmoJ58dk64thnY3sv12aQY-KztrF-A25ucyBI9UiIy1bIpO1BqT")
    options = {data: {title: title,body: body},priority: "high",notification:{title: title,body:body,content_available: true}, collapse_key: "notify_user"}
    return response = fcm.send(ids, options)
  end

  def get_fields
      fields = FieldList.order('category ASC')

      render json: {status: 'SUCCESS', message: 'Loaded fields', data: fields}, status: :ok
    end

  def set_field
      field = FieldList.new(field_params)

      if field.save
        render json: {status: 'SUCCESS', message: 'Field saved', data: field}, status: :ok
      else
        render json: {status: 'ERROR', message: 'Field not saved', data: field.errors}, status: :unprocessable_entity
      end
    end

  #def get_user
    #  user = User.find_by_email(params['email'])
    #  render json: {status: 'SUCCESS', message: 'Loaded user', data: user['mentor']}, status: :ok
    #end

  def get_invites
  		#@user = current_user
  		view_model = InviteViewModel.new
  		invites = Array.new
  		i = 0
  		invites[i] = Hash.new
  		sch = Schedule.where(status: 1, invitee:params['invitee'].to_i)
  		sch.each do |s|
  			if i < 3
  				user = User.where(id: s.host_id)
  				message = Message.where(ref: s['ref'])
  				message.each do |m|
  					view_model.topic = m[:content]
  				end
  				user.each do |u|
  					view_model.inviter = u[:first_name] + ' ' + u[:last_name]
  				end
  				#view_model['img_url'] = user[]
  				if i == 0
  					view_model.date1 = s[:dt]
  				end
  				if i == 1
  					view_model.date2 = s[:dt]
  				end
  				if i == 2
  					view_model.date3 = s[:dt]
  				end
          i = i + 1
  			else
  				invites[i] = view_model
          i = 0
  				view_model = InviteViewModel.new
  			end
  		end
      render json: {status: 'SUCCESS', message: 'Schedule loaded', data: sch}, status: :ok

    end #end def get_invites

  def respond_invite
    msg = {status:2,msg:'Failed'}
    if params.include?('id') && params.include?('invite_id') && params.include?('resp')
      id = params['id'].to_i
      invite_id = params['invite_id'].to_i
      resp = params['resp'].to_i
      msg = {status:3,msg:'Failed'}
      if Schedule.exists?(invite_id)
        sch = Schedule.find(invite_id)
        msg = {status:4,msg:'Failed'}
        ref = sch.ref
        if(resp == invite_id)
          sch.status = 3
          sch.save
          sch_group = Schedule.where(status: 1, ref:ref)
          sch_group.each do |s|
            sch_line = Schedule.find(s.id)
            sch_line.status = 0
            sch_line.save!
          end
        else
          msg = {status:4,msg:'Failed'}
        end
        #init sinch
        msg = {status:1,msg:'Success'}
      end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end

  def decline_invite
    msg = {status:2,msg:'Failed'}
    temp = 'none'
    if params.include?('ref') && params.include?('resp')
      #id = params['id'].to_i
      ref = params['ref'].to_i
      #resp = params['resp']
      msg = {status:3,msg:'Failed'}
      #if Schedule.any?()
      sch_group = Schedule.where(status: 1, ref:ref)
      sch_group.each do |s|
        temp = s.id
        if Schedule.exists?(s.id)
          temp = s.id
          sch_line = Schedule.find(s.id)
          sch_line.status = 2
          sch_line.save!
        end
      end
      msg = {status:1,msg:'Success',temp:sch_group}
      #end
    end
    respond_to do |format|
      format.json {render json: msg}
    end
  end

  private def field_params
    params.permit(:name, :value, :category)
    end
end
