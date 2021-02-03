class RodauthController < ApplicationController
  before_action :current_account, if: -> { rodauth.logged_in? }

  private

end
