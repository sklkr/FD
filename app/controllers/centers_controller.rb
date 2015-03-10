class CentersController < ApplicationController
  before_filter :assign_variables
  def about
  end

  def services
  end

  def map
  end

  def reviews
  end

  def instructors
    @instructors = @center.instructors
  end

  def experience
    @experience = @centerinfo.tag_list
  end

  def hours
  end

  def upcoming
  end

  private
    def assign_variables
      @center = center
      @centerinfo = center.centerinfo 
      @hours = @centerinfo.hour
      @upcoming = @center.services.where('service_type=?','2')
    end
end
