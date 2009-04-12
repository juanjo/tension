# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def flash_message
    messages = ""
    [:notice, :info, :warning, :error].each do|type|
      if flash[type]
        messages= "<div id='flash' class=\"#{type}\">#{flash[type]}</div>"
      end
    end
    messages
  end

end
