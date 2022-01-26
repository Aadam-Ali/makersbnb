feature 'Login' do
  scenario 'The user can login to an existing account' do
    Users.create('j@gmail.com', 'secrets', 'Jasmine')

    visit('/register')

    click_link 'Login'

    expect(page).to have_current_path('/login')

    fill_in :login_email, with: 'j@gmail.com'
    fill_in :login_password, with: 'secrets'

    click_button('Login')
    expect(page).to have_current_path('/spaces')
  end
end
