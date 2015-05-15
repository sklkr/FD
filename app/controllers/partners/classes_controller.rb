module Partners
class ClassesController < BaseController 
layout 'partners'

  def index
	 @fpclasses = current_partner.fpclasses
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
   @fpclass.partner = current_partner
   if @fpclass.save
    redirect_to partners_classes_path
   else
    render :new
   end
  end

  def update
    @fpclass = Fpclass.friendly.find(params[:id])
    if @fpclass.update(permit_params)
     redirect_to partners_classes_path
    else
     render :edit
    end
  end

  def delete

  end

  private
  	def permit_params
      params.require(:fpclass).permit(:name, :date, :recurring, :expiry, :description, :level, :start_time , :duration, :seats, :instructor_id, :type_of, :center_ids => [])
    end

end
end