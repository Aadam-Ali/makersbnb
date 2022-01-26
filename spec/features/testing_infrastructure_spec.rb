feature 'Open Site' do
  scenario 'User opens the site and redirects to register' do
    visit '/'
    expect(page).to have_current_path('/register')
  end
end