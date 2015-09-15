class MedialinksController < ApplicationController

  before_filter :fetch_profile_from_params
  before_filter :ensure_own_medialinks

  before_action :set_medialink, only: [:edit, :update, :destroy]

  def index
    @medialinks = @profile.medialinks.order(:position)
  end

  def new
    @medialink = Medialink.new
    build_missing_translations(@medialink)
  end

  def edit
    build_missing_translations(@medialink)
  end

  def update
    if @medialink.update_attributes(medialink_params)
      redirect_to profile_medialinks_path(@profile), notice: (I18n.t('flash.medialink.updated'))
    else
      render action: 'edit'
    end
  end

  def destroy
    @medialink.destroy
    redirect_to profile_medialinks_path(@profile), notice: (I18n.t('flash.medialink.destroyed'))
  end

  def create
    @medialink = @profile.medialinks.build(medialink_params)
    if @medialink.save
      flash[:notice] = (I18n.t('flash.medialink.created'))
      redirect_to profile_medialinks_path(@profile)
    else
      flash[:notice] = (I18n.t('flash.medialink.error'))
      render action: 'new'
    end
  end

  def sort
    params[:medialink].each_with_index do |id, index|
      Medialink.where(id: id).update_all(position: index+1)
    end
    render nothing: true
  end

  protected

  def fetch_profile_from_params
    @profile = Profile.find(params[:profile_id])
  end

  def ensure_own_medialinks
    if @profile != current_profile
      redirect_to root_path, notice: 'Sorry, but you can not edit other peoples medialinks. OK?'
    else
      true
    end
  end

  private

  def set_medialink
    @medialink = @profile.medialinks.find(params[:id])
  end

  def medialink_params
    params.require(:medialink).permit(
      :position,
      translations_attributes: [:id, :url, :title, :description, :locale]
      )
  end

  def build_missing_translations(object)
    I18n.available_locales.each do |locale|
      unless object.translated_locales.include?(locale)
        object.translations.build(locale: locale)
      end
    end
  end

end
