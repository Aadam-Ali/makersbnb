feature 'sign in page' do
  scenario 'the user can enter a name and submit' do
    visit('/sessions/new')
    fill_in :username, with: 'Stacy'
    click_button('Signup')
    expect(page).to have_current_path('/spaces')
    expect(page).to have_content('Hi Stacy')
  end
end
