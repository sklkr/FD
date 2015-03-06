module Partners
class DashboardController < ApplicationController
skip_before_filter :authenticate!
before_filter :partner_authenticated?
layout 'partnerdashboard'
  def summary

  end
end
end