class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # WARN: disable csrf
  skip_before_action :verify_authenticity_token
  include SessionHelper
end
