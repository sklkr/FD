module Partners::Centers
  class ServicesController < ApplicationController 
  skip_before_filter :authenticate!
  before_filter :partner_authenticated?
  before_filter :partner_accessable?
  before_filter { params[:id] && @service = Service.find(params[:id])}

  layout 'partnerdashboard'
    def index
      regular = center.services.regular.includes(:category)
      @ymka = regular.where(category_id: [1,3,6,8])
      @ssc = regular.where(category_id: [4,7])
      @gs = regular.where(category_id: [2,5])
    end

    def new
      @service = Service.new
      @instructors = center.instructors
    end

    def create 
      @service = Service.new(service_params)
      @service.center_id = center.id
      @service.instructor_ids = params.require(:service).permit(:instructor_ids => [])['instructor_ids'].reject(&:blank?)
      if @service.save
        flash[:notice] = 'Service created'
        params[:id] = @service.id
        redirect_to partners_center_services_path
      else
        render :text => 'something went wrong'
      end
    end

    def show
      @instructors = center.instructors
    end

    def update
      @service.instructor_ids = params.require(:service).permit(:instructor_ids => [])['instructor_ids'].reject(&:blank?)
      if @service.update_attributes(service_params)
        flash[:notice] = 'Details updated'
        redirect_to partners_center_services_path
      else
        render :text => 'something went wrong'
      end
    end

    def upcoming
      @upcoming = center.services.where('service_type=?','2')
    end

    private
      def service_params
        params.require(:service).permit(:service_type, :category_id, :name,:days, :validity, :time_taken, :original_price, :selling_price, :gender_id, :schedule, :service_desc, :expired_on, :start_date, :end_date, :seats)
      end
  end
end