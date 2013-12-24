class BusesResponder < ActionController::Responder
  include Responders::FlashResponder

  def set_flash_message?
    true
  end

  def has_errors?
    resource.empty? || resource.without_gps_data.any?
  end
end
