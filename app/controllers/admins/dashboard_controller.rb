module Superadmins
class DashboardController < ApplicationController 
layout 'admindashboard'
before_filter :admin_authenticated?

  def index
	  	
  end

  def new
    
  end

end
end