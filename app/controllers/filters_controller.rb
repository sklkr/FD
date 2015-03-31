class FiltersController < ApplicationController
before_filter :searcher

  def index

  end

  def list
    @c = Center.ransack(params[:q])
    @cbase = @c.result(distinct: true).page(params[:page]).per(3)
    @data = @cbase.group_by {|c| [c.services, c.centerinfo]}.sort_by {|k,v| v[0].name}
  end


  def grid
  	#@q = Centerinfo.ransack(params[:q])
  	#@centers = @q.result
    @c = Center.ransack(params[:q])
    @cbase = @c.result(distinct: true).page(params[:page]).per(9)
    @data = @cbase.group_by(&:centerinfo).sort_by{|ci, center| center[0].name}
  end

  def map

  end
    
end
