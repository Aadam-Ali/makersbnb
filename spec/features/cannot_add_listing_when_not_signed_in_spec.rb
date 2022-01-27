feature 'add listing' do
  scenario 'user is redirected to /register when not sigend in' do
    visit('/spaces/new')

    fill_in :name, with: 'A large mansion'
    fill_in :description, with: 'A large mansion in the city'
    fill_in :price, with: 222

    click_button('Create new listing')

    expect(current_path).to eq('/register')
  end
end
