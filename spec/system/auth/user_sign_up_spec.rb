require 'rails_helper'

describe 'User sign up' do
    it 'and see sign up fields' do
        visit root_path
        click_on 'Criar Conta'

        expect(page).to have_field 'Apelido'
        expect(page).to have_field 'E-mail'
        expect(page).to have_field 'Senha'
    end

    it 'and sing up with empty fields' do
      visit root_path
      click_on 'Criar Conta'
      within 'form' do
        click_on 'Criar Conta'
      end

      expect(page).to have_content 'não pode ficar em branco'
    end

    it 'and sign up with success' do
      visit root_path
      click_on 'Criar Conta'
      within 'form' do
        fill_in 'Apelido', with: 'Teste'
        fill_in 'E-mail', with: 'teste@email.com'
        fill_in 'Senha', with: '12345678'
        fill_in 'Confirme sua senha', with: '12345678'
        click_on 'Criar Conta'
      end

      expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
      expect(page).to have_content 'Teste'
      expect(page).to have_content 'Sair'
    end
end
