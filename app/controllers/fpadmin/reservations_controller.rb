module Fpadmin
class ReservationsController < BaseController 
layout 'fpadmin'

  def index
    @reservations = Clasbking.recent.includes(:customer, :fpclass, :center).page params[:page]
  end

  def show

  end

  def destroy

  end
end
end