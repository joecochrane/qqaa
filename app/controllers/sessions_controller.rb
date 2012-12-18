class SessionsController < ApplicationController

def new
		@title = "Sign in"
	end
def create
	  user = User.authenticate(params[:session][:name],
                             params[:session][:password])
		if user.nil? 
			puts 'session name '
			puts params[:session][:name]
			puts 'session password '
			puts params[:session][:password]
			#Rails.logger.info(@user.errors.messages.inspect)
			flash.now[:error] = "Invalid name/password combination."
			@title = "Sign in"
			render 'new'  
		else 
			sign_in user
			redirect_to questions_path
		end
  end
  
 def destroy
    sign_out
    redirect_to questions_path
  end



end
