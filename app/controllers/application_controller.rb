class ApplicationController < ActionController::Base
  def detect_device_variant
    request.variant = request.user_agent&.match?(/iPod|iPhone|iPad|Android/) ? :sp : :pc
  end
end
