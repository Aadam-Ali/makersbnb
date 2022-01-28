feature 'accept or reject a booking' do

  before(:each) do
    owning_user = Users.create('jason@example.com', 'jason123', 'Jason')
    requesting_user = Users.create('freddy@example.com', 'freddy123', 'Freddy')
    property = Properties.create('Jasons Chamber', 'Lovely Dungeon', 80, owning_user.id, '2022-02-01', '2022-02-28')
    @booking_request = Bookings.create(property.id, requesting_user.id, '2022-02-11')

    visit('/login')
    fill_in :login_email, with: 'jason@example.com'
    fill_in :login_password, with: 'jason123'
    click_button('Login')

    visit("/incoming_bookings/#{@booking_request.id}")
  end

  scenario 'content to be shown' do
    expect(page).to have_content("Request for 'Jasons Chamber'")
    expect(page).to have_content("From: freddy@example.com")
    expect(page).to have_content("Date: 2022-02-11")
    expect(page).to have_button('Accept')
    expect(page).to have_button('Reject')
  end

  scenario 'when accepting, user is redirected to requests and request should be gone' do
    click_button('Accept')
    expect(page).to have_current_path('/users/requests')
    expect(page).not_to have_link(href: "/incoming_bookings/#{@booking_request.id}")
  end

  scenario 'when denying, user is redirected to requests and request should be gone' do
    click_button('Reject')
    expect(page).to have_current_path('/users/requests')
    expect(page).not_to have_link(href: "/incoming_bookings/#{@booking_request.id}")
  end
end
