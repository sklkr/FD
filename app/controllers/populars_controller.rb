class PopularsController < ApplicationController
  CATEGORY = ['','yoga', 'gym', 'meditation', 'spa', 'swimming', 'adventure', 'consultant', 'kids']
  def index
    @centers = Center.all.includes(:centerinfo, :accountinfo, :city)
    # For search 
  	@categories = Category.all
    @cities = cities
    @c = Center.ransack(params[:q])
  end

=begin
  def search
    @cities = cities
    @categories = Category.all
  	city = City.find_by_name(params[:city])
  	@centers = Center.where('city_id=?',city.try(:id))
    params[:cat_id] = params[:category_id]
    params[:category_id] = CATEGORY[params[:category_id].to_i]
    render :index
  end
=end
end
