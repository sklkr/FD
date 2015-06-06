module Partners
class ReservationsController < BaseController 
layout 'partners'
  def show
    clasbkings = []
    @fpclasses = current_user.fpclasses.includes(:clasbkings)
    @fpclasses.each {|fpclass| clasbkings << fpclass.clasbkings }
    @clasbkings = clasbkings.flatten
    past = []
    @pastfpclasses = Fpclass.unscoped.where('partner_id=?',current_user.id).pluck(:id)
    @past = Clasbking.unscoped.where('expired_at < ?', Time.now).where(:fpclass_id=>@pastfpclasses)
  end
end
end