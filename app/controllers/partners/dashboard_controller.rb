module Partners
	class DashboardController < ApplicationController 
	  def index
	  	redirect_to partners_login_path
	  end
	end
end