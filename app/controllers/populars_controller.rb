class PopularsController < ApplicationController
  def index
    @category = Category.friendly.find(params['category_id'])
    @centers = @category.populars.map(&:center)

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
