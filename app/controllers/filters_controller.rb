class FiltersController < ApplicationController
# before_filter { @c = Center.ransack(params[:q]) }
  def search
  end

  def react_search
    params[:q] = {:place_name_cont_any => params[:place_name_cont_any], :center_type_in => JSON.parse(params[:center_type_in])} unless params[:place_name_cont_any].blank?
    @c = Center.ransack(params[:q])
    @centers = @c.result(distinct: true).includes(:centerinfo, :cphotos)
    render json: @centers
  end

  def react_class_search
    params[:q] = {:recursivedates_ondate_eq => params[:recursivedates_ondate_eq], :centers_place_name_cont_any => params[:place_name_cont_any], :centers_center_type_in => JSON.parse(params[:center_type_in])} unless params[:place_name_cont_any].blank?
    params[:q] = {:recursivedates_ondate_eq => Date.today.strftime("%d-%m-%Y")} if params[:q].blank?
    @c = Fpclass.ransack(params[:q])
    @fpclasses = @c.result(distinct: true)
    @dates = (Date.today..Date.today+13).to_a
    render json: [@fpclasses, @dates]
  end

  def classes
    # old classes and are not much useful
    # merger
    # params[:q] = {:recursivedates_ondate_eq => Date.today.strftime('%Y-%m-%d')} if params['q'].nil?
    # @c = Fpclass.ransack(params[:q])
    # @fpclasses = @c.result(distinct: true)
    # @difference = params['q']['recursivedates_ondate_eq'].to_date - Date.today
    # respond_to do |format|
    #   format.js
    # end
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

  def dates
    @experiences = Experience.order(:name)
    render json: @experiences
  end
end
