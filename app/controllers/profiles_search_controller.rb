class ProfilesSearchController < ApplicationController
  def show
    @profiles = Profile.search((params[:query].present? ? params[:query] : '*')).records
    @tags = ActsAsTaggableOn::Tag.most_used(100)
  end
end
