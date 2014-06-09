module ApplicationHelper
  APPLE_TOUCH_ICONS = %w( 57 72 114 144 ).map do |size|
    ["#{size}x#{size}", "apple-touch-icon-#{size}x#{size}.png"]
  end

  def apple_touch_icons
    APPLE_TOUCH_ICONS
  end
end
