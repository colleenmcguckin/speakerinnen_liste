class ProfilesSearchController < ApplicationController
  def show
    @profiles = Profile.custom_search((params[:query].present? ? params[:query] : '*'))
    @tags = ActsAsTaggableOn::Tag.most_used(100)
  end
end
