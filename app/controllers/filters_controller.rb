class FiltersController < ApplicationController
  def index
  end

  def list
  end

  def grid
  	@q = Centerinfo.ransack(params[:q])
  	@centers = @q.result
  end

  def map
  end
end
