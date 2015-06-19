module Fpadmin
class CouponsController < BaseController
layout 'fpadmin'
before_filter :authenticated?

  def index
    binding.pry
  end

  def show
  end

  def destroy
  end
end
end
