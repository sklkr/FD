module Partners
class ReservationsController < BaseController 
layout 'partners'
  def show
    clasbkings = []
    @fpclasses = current_partner.fpclasses.includes(:clasbkings)
    @fpclasses.each {|fpclass| clasbkings << fpclass.clasbkings }
    @clasbkings = clasbkings.flatten
    past = []
    @pastfpclasses = current_partner.fpclasses.expired.includes(:clasbkings)
    @pastfpclasses.each {|fpclass| past << fpclass.clasbkings }
    @past = past.flatten
  end
end
end