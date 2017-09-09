ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def is_logged_in?
    !session[:user_id].nil?
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def log_in(username, password)
    post login_path, params: { user: {
      username: username,
      password: password
    }}
  end
end
