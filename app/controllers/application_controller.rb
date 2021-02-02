# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pagy::Backend

  def authenticate
    rodauth.require_authentication # redirect to login page if not authenticated
  end
end
