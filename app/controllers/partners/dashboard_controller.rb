module Partners
class DashboardController < ApplicationController
skip_before_filter :authenticate!
  def summary

  end
end
end