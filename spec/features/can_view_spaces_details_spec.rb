feature 'show spaces details' do
  
  scenario 'view the details of a space' do
    DatabaseConnection.query("INSERT INTO properties (id, name, description, owner, price) 
    VALUES (1,'House', 'Lovely House', 'Lovely Owner', 80);", [])
    
    visit('/spaces')
    click_on 'House'
    expect(page).to have_current_path('/spaces/:1')

    expect(page).to have_content('House')
    expect(page).to have_content('Lovely House')
    expect(page).to have_content('Lovely Owner')
    expect(page).to have_content('80')
  end

  scenario 'request booking of the space' do
    visit('/spaces/:1')
    click_button('Book')
    expect(page).to have_current_path('/successful')
  end
end