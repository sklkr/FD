class FiltersController < ApplicationController
  before_action :assigners, :only => [:grid, :list]
  def index
  end

  def list
  end

  def grid
  	#@q = Centerinfo.ransack(params[:q])
  	#@centers = @q.result
  end

  def map

  end
    
  def assigners
    @c = Center.ransack(params[:q])
    @centers = @c.result(distinct: true).includes(:centerinfo, :services).inject([]) { |center, p| center << p.centerinfo }
  end

end
