describe SearchableController do

  before do
    Profile.__elasticsearch__.index_name = 'profiles_test'
    Profile.__elasticsearch__.import
    Profile.__elasticsearch__.refresh_index!
  end

  it
end
