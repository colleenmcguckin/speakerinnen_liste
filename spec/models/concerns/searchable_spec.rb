describe Searchable do
  let(:profile) { FactoryGirl.create(:profile) }

  before do
    Profile.__elasticsearch__.create_index! force:true
    Profile.__elasticsearch__.import
    # Profile.__elasticsearch__.refresh_index!
  end

  describe 'as_indexed_json' do
    it 'should include medialinks' do
      pp Profile.__elasticsearch__
      # expect(Profile.__elasticsearch__).to have_attributes(medialinks)
    end
  end
end
