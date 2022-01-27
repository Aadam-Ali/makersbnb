feature 'View all spaces' do
  scenario 'It can show me a list of all spaces' do
    user = Users.create('j@gmail.com', 'secrets', 'Jasmine')
    Properties.create('House', 'Lovely House', 50, user.id, '2022-02-01', '2022-02-28')
    Properties.create('Cottage', 'Lovely Cottage', 50, user.id, '2022-02-01', '2022-02-28')
    
    visit '/login'

    fill_in :login_email, with: 'j@gmail.com'
    fill_in :login_password, with: 'secrets'

    click_button('Login')

    expect(page).to have_content('House')
    expect(page).to have_content('Lovely House')
    expect(page).to have_content('Cottage')
    expect(page).to have_content('Lovely Cottage')
  end
end
