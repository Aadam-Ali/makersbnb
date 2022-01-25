feature 'View all Spaces' do

  DatabaseConnection.query("INSERT INTO properties (name, description) VALUES ('House', 'Lovely House');", [])
  DatabaseConnection.query("INSERT INTO properties (name, description) VALUES ('Cottage', 'Lovely Cottage');", [])

  scenario 'it can show me a list of all spaces' do
    visit('/spaces')
    expect(page).to have_content('House')
    expect(page).to have_content('Lovely House')
    expect(page).to have_content('Cottage')
    expect(page).to have_content('Lovely Cottage')
  end

end
