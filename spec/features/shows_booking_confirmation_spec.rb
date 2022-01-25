feature 'shows booking confirmation' do
  scenario 'after clicking book button, a confirmation should be printed' do
    DatabaseConnection.query("INSERT INTO properties (id, name, description, owner, price) 
    VALUES (1,'House', 'Lovely House', 'Lovely Owner', 80);", [])
    
    visit('spaces/1')
    click_button('Book')
    expect(page).to have_content('Your booking was successful')
  end
end
