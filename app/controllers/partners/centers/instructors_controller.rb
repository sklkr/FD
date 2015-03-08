module Partners::Centers
class InstructorsController < ApplicationController 
skip_before_filter :authenticate!
before_filter :partner_authenticated?
layout 'partnerdashboard'
  
  def index
    
  end
  def create
    instructor = Instructor.new(permit_params)
    if instructor.save
      flash[:notice] = 'Instructor added'
      redirect_to action: 'instructors'
    else
      render :text => 'something went wrong'
    end
  end

  private
  	def permit_params
      params.require(:instructor).permit(:name, :gender, :mobile, :email, :expertise, :description)
    end
end
end