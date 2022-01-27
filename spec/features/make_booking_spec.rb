feature 'Booking' do
  scenario 'User logs in and makes a booking' do
    user = Users.create('j@gmail.com', 'secrets', 'Jasmine')
    property = Properties.create('House', 'Lovely House', 80, user.id, '2022-02-01', '2022-02-28')
    Properties.create('Cottage', 'Lovely Cottage', 50, user.id, '2022-02-01', '2022-02-28')
    
    visit '/login'

    fill_in :login_email, with: 'j@gmail.com'
    fill_in :login_password, with: 'secrets'

    click_button('Login')

    click_on 'House'

    expect(page).to have_current_path("/spaces/#{property.id}")

    click_button('Book')

    expect(page).to have_current_path('/successful')
    expect(page).to have_content('Your booking was successful')
  end
end