class Admins::BaseController < ApplicationController
  layout 'admins/layouts/application'
  before_action :basic_authenticate

  private

  def basic_authenticate
    authenticate_or_request_with_http_basic('BA') do |name, pass|
      name == ENV['BASIC_AUTH_USERNAME'] && Digest::SHA1.hexdigest(pass) == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end