## Partner Dashboard >> Instructors

module Partners
class InstructorsController < BaseController 
layout 'partners'

  def index
	 @instructors = current_user.instructors
  end

  def new
   @instructor = Instructor.new
  end

  def show
    
  end

  def edit

  end

  def create
   @instructor = Instructor.new(permit_params)
   @instructor.partner = current_user
   if @instructor.save
    redirect_to partners_instructors_path(anchor: "instructor_#{@instructor.id}"), :notice => "Instructor added successfully"
   else
    flash[:alert] = "Something's not right. Please check again"
    render 'new'
   end
  end

  def update

  end

  def delete

  end

  private
    def permit_params
      params.require(:instructor).permit(:name, :email, :mobile, :photo)
    end
end
end