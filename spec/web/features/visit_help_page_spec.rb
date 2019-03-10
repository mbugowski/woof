require 'features_helper'

RSpec.describe 'Visit Help page' do
  it 'is successful' do
    visit '/help'

    expect(page).to have_css('h1', text: 'Help')
  end

  it 'has correct title' do
    expect(page).to have_title "Help | Hanami Sample App"
  end
end