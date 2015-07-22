## Search page

class FiltersController < ApplicationController
# before_filter { @c = Center.ransack(params[:q]) }
before_filter { redirect_to root_url unless current_user }
  def search
  end

  def react_search
    params[:q] = {:place_name_cont_any => params[:place_name_cont_any], :center_type_in => params[:center_type_in].blank? ? '' : JSON.parse(params[:center_type_in])} unless params[:place_name_cont_any].blank?
    @c = Center.ransack(params[:q])
    @centers = @c.result(distinct: true).includes(:centerinfo, :cphotos)
    render json: @centers
  end

  def react_class_search
    params_modifier
    @c = Fpclass.ransack(params[:q])
    start_time, end_time = fetch_timings.collect {|time| time.remove(':').to_i }
    @fpclasses = ClasFetcher.new(date, @c.result.pluck(:id), {start_time: start_time, end_time: end_time}).fetch
    render json: [@fpclasses, dates_fetcher, passport ? passport.clasbkings : [], params[:q][:centers_place_name_cont_any]]
  end

  private
    def params_modifier
      params[:q] = {}
      params[:q].merge!({:centers_place_name_cont_any => params[:place_name_cont_any]}) unless params[:place_name_cont_any].blank?
      params[:q].reverse_merge! :centers_place_name_cont_any => current_user.city_name
    end

    def dates_fetcher
      @dates = (Date.today..Date.today+13).to_a
    end

    def date
      params[:recursivedates_ondate_eq] ? params[:recursivedates_ondate_eq] : Date.today.strftime("%Y-%m-%d")
    end

    def fetch_timings
      params[:time_filter].blank? ? ['01:00', '24:00'] : params[:time_filter].split(";") 
    end
end
