class ApplicationController < ActionController::Base
  before_action :detect_device_variant
  
  def detect_device_variant
    request.variant = request.user_agent&.match?(/iPod|iPhone|iPad|Android/) ? :sp : :pc
  end
end
