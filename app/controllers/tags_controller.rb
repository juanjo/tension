class TagsController < ApplicationController
  def show
    @tag = Tag.find_by_name(params[:id])
    @extensions = Extension.paginate(Extension.find_tagged_with(@tag), :page => params[:page], :per_page => 3)
  end

end
