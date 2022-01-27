feature 'Shows Individual Space' do
  scenario 'View the details of an individual space' do
    user = Users.create('j@gmail.com', 'secrets', 'Jasmine')
    property = Properties.create('House', 'Lovely House', 80, user.id, '2022-02-01', '2022-02-28')
    Properties.create('Cottage', 'Lovely Cottage', 50, user.id, '2022-02-01', '2022-02-28')
    
    visit '/login'

    fill_in :login_email, with: 'j@gmail.com'
    fill_in :login_password, with: 'secrets'

    click_button('Login')

    click_on 'House'

    expect(page).to have_current_path("/spaces/#{property.id}")
    expect(page).to have_content('House')
    expect(page).to have_content('Lovely House')
    expect(page).to have_content(user.name)
    expect(page).to have_content('80')
  end
end
