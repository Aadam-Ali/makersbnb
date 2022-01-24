feature 'User can access the site' do
  scenario 'user opens the site' do
    visit '/'
    expect(page).to have_content 'Hello'
  end
end