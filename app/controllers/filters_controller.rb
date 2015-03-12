class FiltersController < ApplicationController
  def index
  end

  def list
  end

  def grid
  	#@q = Centerinfo.ransack(params[:q])
  	#@centers = @q.result
    @c = Center.ransack(params[:q])
    @centers = @c.result(distinct: true).includes(:centerinfo).inject([]) { |center, p| center << p.centerinfo }
  end

  def map
  end
end
