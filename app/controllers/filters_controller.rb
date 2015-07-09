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
    rcdate = params[:recursivedates_ondate_eq] || Date.today.to_s
    params_modifier
    @c = Fpclass.ransack(params[:q])
    @fpclasses = @c.result.any_classes(rcdate).order('start_time')
    @fpclasses = ClassesParser.new(@fpclasses, Date.parse(rcdate).strftime('%y%m%d'), params[:page].to_i).generate
    @clasbkings = passport ? passport.clasbkings : []
    dates_fetcher
    render json: [@fpclasses, @dates, @clasbkings]
  end

  private
    def params_modifier
      params[:q] = {}
      params[:q].merge!({:centers_place_name_cont_any => params[:place_name_cont_any], :centers_center_type_in => JSON.parse(params[:center_type_in])}) unless params[:place_name_cont_any].blank?
      params[:q].merge!({:centers_slug_eq => params[:centers_slug_eq]}) unless params[:centers_slug_eq].blank?
    end

    def dates_fetcher
      @dates = (Date.today..Date.today+13).to_a
    end
end
