class PartnerCenterinfosController < ApplicationController
  skip_before_filter :authenticate!
  before_filter :partner_authenticated?
  layout 'partnerdashboard'
  include Wicked::Wizard
  steps :centerphotos

  def show
  	binding.pry
  	render_wizard
  end
end
