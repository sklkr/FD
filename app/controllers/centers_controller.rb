class CentersController < ApplicationController
  before_filter :assign_variables
  def about
  end

  def services
    @ymka = center.services.where(category_id: [1,3,6,8])
    @ssc = center.services.where(category_id: [4,7])
    @gs = center.services.where(category_id: [2,5])
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
      @center = center.reload
      @centerinfo = center.centerinfo 
      @hours = @centerinfo.hour
      @accountinfo = center.accountinfo
      @upcoming = @center.services.upcoming
      @photos = Cphoto.where('centerinfo_id=?', @centerinfo.id)
    end
end
