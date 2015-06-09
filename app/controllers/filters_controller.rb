class FiltersController < ApplicationController
before_filter { @c = Center.ransack(params[:q]) }

  def search
    # partial merging
    merger
    @c = Center.ransack(params[:q])
    @centers = @c.result(distinct: true).includes(:centerinfo, :cphotos)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def react_search
    binding.pry
  end

  def react_class_search
    binding.pry
  end

  def classes
    merger
    params[:q] = {:recursivedates_ondate_eq => Date.today.strftime('%Y-%m-%d')} if params['q'].nil?
    @c = Fpclass.ransack(params[:q])
    @fpclasses = @c.result(distinct: true)
    @difference = params['q']['recursivedates_ondate_eq'].to_date - Date.today
    respond_to do |format|
      format.js
    end
  end

  def merger
    params['q']['centers_place_name_cont_any'].sub!("Bangalore", "Bengaluru") unless (params[:q].blank? || params[:q][:centers_place_name_cont_any].blank?)
    params[:q].merge!(:centers_place_name_cont_any => params[:q][:centers_place_name_cont_any].split(',').first) unless (params[:q].blank? || params[:q][:centers_place_name_cont_any].blank?)
    params['q']['place_name_cont_any'].sub!("Bangalore", "Bengaluru") unless (params[:q].blank? || params[:q][:place_name_cont_any].blank?)
    params[:q].merge!(:place_name_cont_any => params[:q][:place_name_cont_any].split(',').first) unless (params[:q].blank? || params[:q][:place_name_cont_any].blank?)
  end

  def center_types
    @types = Center::CENTERTYPES
    render json: @types
  end

  def experiences
    @experiences = Experience.order(:name)
    render json: @experiences
  end
end
