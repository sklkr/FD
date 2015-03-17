class FiltersController < ApplicationController
  def index
  end

  def list
    @c = Center.ransack(params[:q])
    @cbase = @c.result(distinct: true).page(params[:page]).per(1)
    @centers = @cbase.includes(:centerinfo, :services).inject([]) { |center, p| center << p.centerinfo }
  end


  def grid
  	#@q = Centerinfo.ransack(params[:q])
  	#@centers = @q.result
    @c = Center.ransack(params[:q])
    @cbase = @c.result(distinct: true).page(params[:page]).per(6)
    @centers = @cbase.includes(:centerinfo).inject([]) { |center, p| center << p.centerinfo }
  end

  def map

  end
    
end
