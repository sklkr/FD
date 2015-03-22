module Partners::Centers
class InstructorsController < ApplicationController 
skip_before_filter :authenticate!
before_filter :partner_authenticated?
before_filter :partner_accessable? 
before_filter { params[:id] && @instructor = Instructor.find(params[:id])}

layout 'partnerdashboard'
  
  def index
      @instructors = Center.friendly.find(params['center_id']).instructors
  end
  def new
    @instructor = Instructor.new
  end
  def create
    @instructor = Instructor.new(permit_params)
    @instructor.center_id = center.id
    if @instructor.save
      flash[:notice] = 'Instructor added'
      params[:id] = @instructor.id
      render :show
    else
      render :text => 'something went wrong'
    end
  end

  def show

  end
  def update
    if @instructor.update_attributes(permit_params)
      flash[:notice] = 'Updated'
      render :show
    else
      render :text => "Something went wrong"
    end
  end

  private
  	def permit_params
      params.require(:instructor).permit(:name, :gender, :photo, :mobile, :email, :expertise, :description)
    end
end
end