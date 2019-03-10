require 'features_helper'

RSpec.describe 'Visit About page' do
  it 'is successful' do
    visit Web.routes.about_path

    expect(page).to have_css('h1', text: 'About')
  end

  it 'has correct title' do
    expect(page).to have_title "About | Hanami Sample App"
  end
end
