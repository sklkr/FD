module Partners
class ReservationsController < BaseController 
layout 'partners'
  def show
    clasbkings = []
    @fpclasses = current_partner.fpclasses.includes(:clasbkings)
    @fpclasses.each {|fpclass| clasbkings << fpclass.clasbkings }
    @clasbkings = clasbkings.flatten
  end
end
end