feature 'Add New Listing' do
  scenario 'The user will be able to add the description of the new listing details' do
    visit('/register')

    fill_in :username, with: 'Stacy'
    fill_in :email, with: 'Stacy@gmail.com'
    fill_in :password, with: 'secrets'
    
    click_button('Signup')
    
    visit('/spaces/new')

    fill_in :name, with: 'A large mansion'
    fill_in :description, with: 'A large mansion in the city'
    fill_in :price, with: 222 
    fill_in :available_from, with:'2022-01-27'
    fill_in :available_to, with:'2022-12-27'

    click_button('Create new listing')

    expect(page).to have_current_path('/spaces')
    expect(page).to have_content('A large mansion')
  end
end