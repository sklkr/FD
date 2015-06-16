module Fpadmin
class ReservationsController < BaseController 
layout 'fpadmin'
before_filter :authenticated?

  def index
    @reservations = Clasbking.recent.includes(:customer, :fpclass, :center).page params[:page]
    @history = Clasbking.unscoped.where('expired_at < ?', Time.now).includes(:customer, :fpclass, :center).page params[:page]
  end

  def show

  end

  def destroy

  end
end
end