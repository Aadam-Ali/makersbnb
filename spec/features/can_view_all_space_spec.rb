feature 'View all Spaces' do

  scenario 'it can show me a list of all spaces' do
    DatabaseConnection.query("INSERT INTO properties (id, name, description) VALUES (1,'House', 'Lovely House');", [])
    DatabaseConnection.query("INSERT INTO properties (id, name, description) VALUES (2, 'Cottage', 'Lovely Cottage');", [])
    
    visit('/spaces')
    expect(page).to have_content('House')
    expect(page).to have_content('Lovely House')
    expect(page).to have_content('Cottage')
    expect(page).to have_content('Lovely Cottage')
  end

end
