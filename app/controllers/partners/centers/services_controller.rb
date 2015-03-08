module Partners::Centers
  class ServicesController < ApplicationController 
  skip_before_filter :authenticate!
  before_filter :partner_authenticated?
  layout 'partnerdashboard'
    def index

    end

    def 

    def create 
      service = Service.new(service_params)
      if service.save
        flash[:notice] = 'Details updated'
        redirect_to action: 'service_setup'
      else
        render :text => 'something went wrong'
      end
    end

    private
      def service_params
        params.require(:user).permit(:type, :category_id, :name, :validity, :time_taken, :original_price, :selling_price, :gender_id, :schedule, :service_desc, :expired_on, :start_date, :end_date, :seats)
      end
  end
end