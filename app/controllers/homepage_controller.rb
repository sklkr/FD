class HomepageController < ApplicationController
  def index
  	@categories = Category.all
  	@c = Center.ransack(params[:q])
  end
end
