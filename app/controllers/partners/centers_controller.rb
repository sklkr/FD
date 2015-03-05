module Partners
class CentersController < ApplicationController
skip_before_filter :authenticate!
  def account_details
  end
  def denter_details
  end
  def service_setup
  end
  def instructors
  end
  def pass
  end
  def coupon
  end
end
end