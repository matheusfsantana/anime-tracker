require 'rails_helper'

describe 'User sees homepage' do
  it 'sees homepage' do
    visit root_path

    expect(page).to have_content('AnimeTracker')

    within('nav') do
      expect(page).to have_link('Login')
      expect(page).to have_link('Criar Conta')
    end
  end
end
