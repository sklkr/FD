class UnauthorizedController < ActionController::Metal
  include ActionController::UrlFor
  include ActionController::Redirecting
  include Rails.application.routes.url_helpers
  include Rails.application.routes.mounted_helpers

  delegate :flash, :to => :request

  def self.call(env)
    @respond ||= action(env['warden.options'][:action])
    @respond.call(env)
  end

  def respond
    unless request.get?
      message = env['warden.options'].fetch(:message, "unauthorized.user")
      flash.alert = I18n.t(message)
    end
    flash[:alert] = "Please check your credentials"
    redirect_to new_session_path
  end

  def partner
    unless request.get?
      message = env['warden.options'].fetch(:message, "unauthorized.user")
      flash.alert = I18n.t(message)
    end
    flash[:alert] = "Please check your credentials"
    redirect_to partners_path
  end

  def unauthenticated
    
  end
end