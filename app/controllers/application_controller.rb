class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # WARN: disable csrf
  skip_before_action :verify_authenticity_token
  include SessionHelper
  before_action :set_format

private
  def set_format
    request.format = 'json'
  end
end
