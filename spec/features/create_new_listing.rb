feature 'Create new listing button' do
  scenario 'the user will submit the button to be redirected to create listing page' do
    visit('/spaces')
    click_button('Create new listing')
    expect(page).to have_current_path('/new_listing')
    expect(page).to have_content('Create a new listing')
  end
end