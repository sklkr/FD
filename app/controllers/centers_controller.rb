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
      @center = center.reload
      @centerinfo = center.centerinfo 
    end
end
