## Admin Dashboard >> Centers

module Fpadmin
class CentersController < BaseController 
layout 'fpadmin'
before_filter :authenticated?

  def index
    @q = Center.ransack(params[:q])
    @q.build_condition if @q.conditions.empty?
    @q.build_sort if @q.sorts.empty?
    @centers = @q.result.page(params[:page])
  end

  def update
    @center = Center.find(params[:id])
    if @center && @center.update_attributes(permit_params)
      render js: "$('#center_#{params[:id]} .btn').val('updated')"
    else
      render js: "alert('Something went wrong');"
    end
  end

  private
    def permit_params
      params.require(:center).permit(:pricetag)
    end
end
end