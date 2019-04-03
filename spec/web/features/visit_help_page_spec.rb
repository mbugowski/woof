require 'features_helper'

RSpec.describe 'Visit Help page' do
  it 'is successful' do
    visit Web.routes.help_path

    expect(page).to have_css('h1', text: 'Help')
  end

  it 'has correct title' do
    expect(page).to have_title "Help | Hanami Sample App"
  end
end
