require 'rails_helper'

describe 'User sees homepage' do
  it 'sees homepage' do
    visit root_path
    expect(page).to have_content('Bem vindo')
  end
end
