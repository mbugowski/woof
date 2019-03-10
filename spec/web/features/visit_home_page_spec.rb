require 'features_helper'

RSpec.describe 'Visit Home page' do
  it 'is successful' do
    visit Web.routes.root_path

    expect(page).to have_css('h1', text: 'Sample App')
  end

  it 'has correct title' do
    expect(page).to have_title "Hanami Sample App"
  end
end
