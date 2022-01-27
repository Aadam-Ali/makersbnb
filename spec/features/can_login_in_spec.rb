feature 'Login' do
  scenario 'user can login to an existing account' do 
    visit('/sessions/new')
    click_link 'Login'
    expect(page).to have_current_path('/login/new')
    fill_in :login_email, with: 'j@gmail.com'
    fill_in :login_password, with: 'secrets'
    click_button('Login')
    expect(page).to have_current_path('/spaces')
  end

end