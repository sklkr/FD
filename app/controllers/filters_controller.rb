class FiltersController < ApplicationController
before_filter :searcher

  def index

  end

  def list
    @c = Center.ransack(params[:q])
    @cbase = @c.result(distinct: true).page(params[:page]).per(3)
    @centers = @cbase.includes(:centerinfo, :services).inject([]) { |center, p| center << p.centerinfo }
  end


  def grid
  	#@q = Centerinfo.ransack(params[:q])
  	#@centers = @q.result
    @c = Center.ransack(params[:q])
    @cbase = @c.result(distinct: true).page(params[:page]).per(9)
    @centers = @cbase.includes(:centerinfo).inject([]) { |center, p| center << p.centerinfo }
  end

  def map

  end
    
end
