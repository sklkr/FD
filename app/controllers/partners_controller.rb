class PartnersController < ApplicationController
layout 'homepage'
  def index
  end

  def new
  	@partner = Partner.new
  	
  end
end
