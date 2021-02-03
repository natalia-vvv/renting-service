# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pagy::Backend

  def authenticate
    rodauth.require_authentication # redirect to login page if not authenticated
  end

  def current_account
    @current_account ||= Account.find(rodauth.session_value)
  rescue ActiveRecord::RecordNotFound
    rodauth.logout
    rodauth.login_required
  end
  helper_method :current_account

  def current_user
    @current_user ||= current_account.user
  end
  helper_method :current_user

end
