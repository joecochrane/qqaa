class PagesController < ApplicationController
  def home
		@title = "Front Page"
	end
	
  def index	
  end
  
  def about
	@title = "About"
  end
  
  def contact
  end

end
