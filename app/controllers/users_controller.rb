require 'sanitize'
class UsersController < ApplicationController
 	before_filter :authenticate, :only => [:index, :edit, :update ]
	before_filter :admin_user,   :only => :destroy
  

	
	def banned
		@users = User.where("banned =?", true)
	end

	
	def upvote_user
		puts "got to upvote_user"
		@to = params[:id]
		@user = User.find(@to)     
		@uper = User.find(current_user.id)
		puts '@to ' + @to.to_s
		
		up = User.get_up(@user.upvotesfrom,current_user.id)   # string list of users that have previously voted for upee plus the uper
		upper = User.get_up(@uper.upvotesto,@to)			# string list of users that uper has previously voted for plus the upee

		puts 'up ' + up
		puts 'upper ' + upper
		
		if @user.update_attribute(:upvotesfrom , up )
				puts 'success writing to db'	
			else
				puts 'failure writing to db'
				Rails.logger.info(@user.errors.messages.inspect)
			end
		if @uper.update_attribute(:upvotesto , upper )
				puts 'success writing to db'
			else
				puts 'failure writing to db'
				Rails.logger.info(@user.errors.messages.inspect)
			end		
	end
	
	def downvote_user
		puts "got to downvote_user"
		@to = params[:id]   
		@user = User.find(@to) 
		@uper = User.find(current_user.id)
		
		down = User.get_down(@user.upvotesfrom,current_user.id)
		downer = User.get_down(@uper.upvotesto,@to)

		puts 'down ' + down
		puts 'downer ' + downer
		
		if @user.update_attribute(:upvotesfrom , down )
				puts 'success writing to db'
			else
				puts 'failure writing to db'
			end
		if @uper.update_attribute(:upvotesto , downer )
				puts 'success writing to db'
			else
				puts 'failure writing to db'
			end		
	end
	
	
  # GET /users
  # GET /users.json
  def index
   
	@title = "All users"
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
   @user = User.find(params[:id])
	@users = User.select("id, name")
   @questions = Question.where("user_id =?",  @user.id ).all
   @answers = Answer.where("user_id =?",  @user.id ).all
   @qtexts = Question.select("id,text")
	@title = @user.name
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end


  
  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
	
	@title = "Sign up"
    respond_to do |format|
      format.html # new.html.haml
      format.json { render :json => @user }
	 
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
	@title = "Edit user"
  end

   # GET /users/1/editadmin
  def editadmin
    @user = User.find(params[:id])
	@title = "Admin Edit user"
  end
  
  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
	@user.update_attribute(:upvotesfrom, "")
	@user.update_attribute(:upvotesto, "")
	@user.update_attribute(:banned, false)
	@user.update_attribute(:password, params[:user][:password])
	if @user.name == 'rakish'
			@user.update_attribute(:admin, true)
		else
			@user.update_attribute(:admin, false)
	end
    respond_to do |format|
      if @user.save
			dirty = @user.background
			clean = Sanitize.clean(dirty, Sanitize::Config::RELAXED)
			@user.update_attribute(:background ,  clean )

	     sign_in @user
		 flash[:success] = "Welcome to the Sample App!"
        format.html { redirect_to :controller => 'questions', :action => 'index'  }
        format.json { render :json => @user, :status => :created, :location => @user }
		
     else
         format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
	
		respond_to do |format|
			if @user.update_attributes(params[:user])
					dirty = @user.background
					clean = Sanitize.clean(dirty, Sanitize::Config::RELAXED)
					@user.update_attribute(:background ,  clean )	
				format.html { redirect_to @user }
				format.json { head :ok }
				
			else
				format.html { render :action => "edit" }
				format.json { render :json => @user.errors, :status => :unprocessable_entity }
				@title = "Edit user"
			end		
    end	
  end

  # DELETE /users/1
  # DELETE /users/1.json
 def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end 
  
   private
    def authenticate
      deny_access unless signed_in?
    end
     def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
   def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
