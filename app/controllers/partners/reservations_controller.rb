module Partners
class ReservationsController < BaseController 
layout 'partners'
  def show
    clasbkings = []
    @fpclasses = current_partner.fpclasses.includes(:clasbkings)
    @fpclasses.each {|fpclass| clasbkings << fpclass.clasbkings }
    @clasbkings = clasbkings.flatten
    @past = current_partner.clasbkings.unscoped.where('expired_at < ?', Time.now)
  end
end
end