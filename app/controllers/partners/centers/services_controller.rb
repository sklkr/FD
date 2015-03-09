module Partners::Centers
  class ServicesController < ApplicationController 
  skip_before_filter :authenticate!
  before_filter :partner_authenticated?
  layout 'partnerdashboard'
    def index
      
    end

    def new
      @service = Service.new
    end

    def create 
      @service = Service.new(service_params)
      @service.center_id = center.id
      if @service.save
        flash[:notice] = 'Service created'
        params[:id] = @service.id
        render :show
      else
        render :text => 'something went wrong'
      end
    end

    def show
      @service = Service.find(params[:id])
    end

    def update
      @service = Service.find(params[:id])
      binding.pry
      if @service.update_attributes(service_params)
        flash[:notice] = 'Details updated'
        render :show
      else
        render :text => 'something went wrong'
      end
    end

    private
      def service_params
        params.require(:service).permit(:type, :category_id, :name,:days, :validity, :time_taken, :original_price, :selling_price, :gender_id, :schedule, :service_desc, :expired_on, :start_date, :end_date, :seats)
      end

      def center
        Center.friendly.find(params['center_id'])
      end
  end
end