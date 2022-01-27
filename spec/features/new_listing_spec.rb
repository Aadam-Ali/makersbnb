feature 'add new listing details' do
  scenario 'The user will be able to add the description of the new listing details' do
  
    visit('/sessions/new')
    fill_in :username, with: 'Stacy'
    click_button('Signup')
    
    visit('/spaces/new')
    fill_in :name, with: 'A large mansion'
    fill_in :description, with: 'A large mansion in the city'
    fill_in :price, with: 222 

    click_button('Create new listing')

    expect(page).to have_current_path('/spaces')
    expect(page).to have_content('A large mansion')

  end
end