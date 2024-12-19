require 'rails_helper'

describe 'User sign in' do
    it 'and see sign in fields' do
        visit root_path
        click_on 'Login'

        expect(page).to have_field 'E-mail'
        expect(page).to have_field 'Senha'
    end

    it 'and sign in with success' do
        user = User.create!(email: 'teste@gmail.com', password: '12345678', nickname: 'teste')

        visit root_path
        click_on 'Login'
        fill_in 'E-mail', with: 'teste@gmail.com'
        fill_in 'Senha', with: '12345678'
        click_on 'Entrar'

        expect(current_path).to eq profile_path(user.nickname)
        expect(page).to have_content 'Login efetuado com sucesso.'
    end

    it 'and sign out with success' do
        User.create!(email: 'teste@gmail.com', password: '12345678', nickname: 'teste')

        visit root_path
        click_on 'Login'
        fill_in 'E-mail', with: 'teste@gmail.com'
        fill_in 'Senha', with: '12345678'
        click_on 'Entrar'
        click_on 'Sair'

        expect(current_path).to eq root_path
        expect(page).to have_content 'Logout efetuado com sucesso.'
    end

    it 'and fill invalid email or password' do
        User.create!(email: 'teste@gmail.com', password: '12345678', nickname: 'teste')

        visit root_path
        click_on 'Login'
        fill_in 'E-mail', with: 'teste'
        fill_in 'Senha', with: '123456'
        click_on 'Entrar'

        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'E-mail ou senha inválidos.'
    end
end
