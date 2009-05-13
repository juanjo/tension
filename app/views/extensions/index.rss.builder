xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title APP_CONFIG['tension']['site_name']
    xml.description APP_CONFIG['tension']['site_summary']
    xml.link extensions_url

    for extension in @extensions
      xml.item do
        xml.title extension.name
        xml.description extension.description
        xml.pubDate extension.created_at.to_s(:rfc822)
        xml.link extension_url(extension)
        xml.author extension.author.name
      end
    end
  end
end

