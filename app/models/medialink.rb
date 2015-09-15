class Medialink < ActiveRecord::Base
  include AutoHtml

  belongs_to :profile
  validates :title, :url, presence: true
  translates :title, :url, :description, fallbacks_for_empty_translations: true
  accepts_nested_attributes_for :translations

  auto_html_for :url do
    html_escape
    image
    youtube width: 400, height: 250
    vimeo width: 400, height: 250
    simple_format
    link target: '_blank', rel: 'nofollow', class: 'content__link--bg'
  end

  def as_json
    attributes.slice(
      'url',
      'title',
      'description',
      'position'
    )
  end

  # to have the correct language variable for the yml file
  def language(translation)
    if translation.object.locale == :en && I18n.locale == :de
      'Englische'
    elsif translation.object.locale == :en && I18n.locale == :en
      'English'
    elsif translation.object.locale == :de && I18n.locale == :en
      'German'
    else
      'Deutsche'
    end
  end
end
