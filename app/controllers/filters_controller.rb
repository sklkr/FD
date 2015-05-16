class FiltersController < ApplicationController
before_filter { @c = Center.ransack(params[:q]) }

  def search
    # partial merging
    params[:q].merge!(:place_name_cont_any => params[:q][:place_name_cont_any].split(',').first) unless (params[:q].blank? || params[:q][:place_name_cont_any].blank?) 
    @c = Center.ransack(params[:q])
    @centers = @c.result(distinct: true).includes(:centerinfo, :cphotos)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def classes
    @c = Fpclass.ransack(params[:q])
    @c = Fpclass.ransack(:recursivedates_ondate_eq => Date.today.strftime('%Y-%m-%d')) if params['q'].nil?
    @fpclasses = @c.result(distinct: true)
    respond_to do |format|
      format.js
    end
  end
    
end
