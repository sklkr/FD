module Partners
class ClassesController < BaseController 
layout 'partners'

  def index
	 @fpclasses = current_user.fpclasses
   @expired = Fpclass.unscoped.where('partner_id=?', 50).where("expiry<?", Time.now)
   respond_to do |format|
    format.html
    format.xml { render xml: @classes.to_xml }
    format.json { render json: @classes.to_json }
   end
  end

  def new
    @fpclass = Fpclass.new
  end

  def edit
    @fpclass = Fpclass.friendly.find(params[:id])
  end

  def create
   @fpclass = Fpclass.new(permit_params)
   @fpclass.partner = current_user
   @fpclass.rcdates = @fpclass.search_dates
   if @fpclass.save
    redirect_to partners_classes_path, :notice => "Class Noted Successfully "
   else
    flash[:alert] = "Something's not right. Please check again"
    render :new
   end
  end

  def update
    @fpclass = Fpclass.friendly.find(params[:id])
    if @fpclass.update(permit_params) && update_rcdates
     redirect_to partners_classes_path, :notice => "Class updated :)"
    else
     flash[:alert] = "Something's not right. Please check again"
     render :edit
    end
  end

  def destroy
    @fp = Fpclass.friendly.find(params[:id])
    if @fp.destroy
      redirect_to partners_classes_path
    else
      render :text => "something went wrong"
    end
  end

  private
  	def permit_params
      params['fpclass']['timings'] = params['fpclass']['timings'].reject(&:blank?)
      params.require(:fpclass).permit(:name, :date, :recurring, :expiry, :description, :level, :start_time , :duration, :seats, :instructor_id, :type_of, :center_ids => [], timings: [])
    end

    def update_rcdates
      @fpclass.rcdates = @fpclass.search_dates
      @fpclass.save
    end
end
end
