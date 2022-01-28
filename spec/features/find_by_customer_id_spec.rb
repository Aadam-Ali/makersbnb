feature 'Find bookings by customer ID' do
  scenario 'Will be able to display any bookings currently held by a customer' do

    user = Users.create('justine@test.com', 'secrets', 'Justine')
    property = Properties.create('House', 'Lovely House', 50, user.id, '2022-02-01', '2022-02-28')
    Properties.create('Cottage', 'Lovely Cottage', 50, user.id, '2022-02-01', '2022-02-28')
    
    booking = Bookings.create(property.id, user.id, '2022-02-02')

    visit '/login'

    fill_in :login_email, with: 'justine@test.com'
    fill_in :login_password, with: 'secrets'

    click_button('Login')
    click_link('Bookings')

    expect(page).to have_content('House')
  end
end
