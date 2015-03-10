class FiltersController < ApplicationController
  def index
  end

  def list
  end

  def grid
  	#@q = Centerinfo.ransack(params[:q])
  	#@centers = @q.result
    @c = Center.ransack(params[:c])
    @centers = @c.result.inject([]) { |center, p| center << p.centerinfo }
  end

  def map
  end
end
