feature 'Register' do
  scenario 'The user can register a new account' do
    visit('/register')

    fill_in :username, with: 'Stacy'
    fill_in :email, with: 'stacy@gmail.com'
    fill_in :password, with: 'secrets'

    click_button('Signup')

    expect(page).to have_current_path('/spaces')
    expect(page).to have_content('Hi Stacy')
  end
end
