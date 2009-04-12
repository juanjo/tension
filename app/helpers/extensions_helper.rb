module ExtensionsHelper
  def website_url(extension)
    extension.website? ? link_to(extension.website, extension.website) : '<i>Not defined</i>'
  end
end
