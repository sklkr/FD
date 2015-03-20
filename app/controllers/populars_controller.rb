class PopularsController < ApplicationController
  CATEGORY = ['','yoga', 'gym', 'meditation', 'spa', 'swimming', 'adventure', 'consultant', 'kids']
  def index
    @services = Category.find_lazy(params[:category_id]).try(:services)
    unless @services.nil?
      @centers = @services.inject([]) { |centerids, service| centerids << service.center_id; centerids; }
      @centers = Center.find(@centers)
    end
    # For search 
  	@categories = Category.all
    @cities = cities
    @city_names = city_names
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
