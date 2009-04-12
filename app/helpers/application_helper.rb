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

  def navigation(*links)
      items = []
      links.each do |link|
        if (controller.controller_name.to_sym == link[0])
          items << content_tag(:li, "#{link[1]}", :class => "active")
        else
          items << content_tag(:li, link_to("#{link[1]}", link[0], :title => "Go to #{link[1]}"))
        end
      end
      content_tag :ul, items, :id => 'tabnav'
  end


end
