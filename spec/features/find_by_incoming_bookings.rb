feature 'Find incoming bookings' do
  scenario 'Will be able to display any bookings requests to the property owners' do

    user = Users.create('paul@test.com', 'secrets', 'paul')
    property = Properties.create('House', 'Lovely House', 50, user.id, '2022-02-01', '2022-02-28')
    Properties.create('Cottage', 'Lovely Cottage', 50, user.id, '2022-02-01', '2022-02-28')
    
    booking = Bookings.create(property.id, user.id, '2022-02-02')

    visit '/login'

    fill_in :login_email, with: 'paul@test.com'
    fill_in :login_password, with: 'secrets'
    click_button('Login')
    
    click_button('Requests')
    expect(page).to have_content('')

    click_link('View Request')
    
  end
end