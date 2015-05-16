class HomepageController < ApplicationController
  before_action :to_search, :only => [:index]
  
  def index
  	@categories = Category.all
  	@c = Center.ransack(params[:q])
  end

  private
  	def to_search
  		redirect_to search_path unless current_user.nil?
  	end
end
