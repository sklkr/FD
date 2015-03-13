class CentersController < ApplicationController
  before_filter :assign_variables
  def about
  end

  def services
    unless params['category_id'].nil?
      d = Category.friendly.find(params['category_id']).id
      if d == 1 || d == 3 || d == 8 || d == 6
        @ymka = center.services.where(category_id: [1,3,6,8])
      elsif d == 4 || d == 7
        @ssc = center.services.where(category_id: [4,7])
      elsif d == 2 || d == 5
       @gs = center.services.where(category_id: [2,5])
      end    
    else 
       @ymka = center.services.where(category_id: [1,3,6,8])
       @ssc = center.services.where(category_id: [4,7])
       @gs = center.services.where(category_id: [2,5])
    end
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
