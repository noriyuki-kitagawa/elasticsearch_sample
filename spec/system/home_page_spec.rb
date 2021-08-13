require 'system_helper'

RSpec.describe 'home page', type: :system do
  it 'ルートページが表示されること' do
    visit root_url

    expect(page).to have_content 'ホームだよ'
  end
end
