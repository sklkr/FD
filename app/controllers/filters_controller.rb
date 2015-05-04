class FiltersController < ApplicationController
before_filter :searcher

  def search
    @c = Center.ransack(params[:q])
    @data = @c.result(distinct: true).includes(:centerinfo, :cphotos).page(params[:page]).per(5)
  end

  def list
    
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
