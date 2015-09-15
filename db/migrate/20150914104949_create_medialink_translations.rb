class CreateMedialinkTranslations < ActiveRecord::Migration
  def self.up
		Medialink.create_translation_table!({
      url: :text,
			title: :text,
			description: :text
		}, {
			:migrate_data => true
		})
  end

	def self.down
		Medialink.drop_translation_table! :migrate_data => true
	end

end

