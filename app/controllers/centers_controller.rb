class CentersController < ApplicationController
  before_filter :assign_variables
  before_filter :searcher

  def about
    
  end

  def map
  end

  def reviews
  end

  def instructors
    @instructors = @center.instructors
  end

  def experience
    @experience = @centerinfo.experiences
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
      @accountinfo = center.accountinfo
      @upcoming = @center.services.upcoming
      @photos = Cphoto.where('centerinfo_id=?', @centerinfo.id)
    end
end
