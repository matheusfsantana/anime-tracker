
describe 'user try to update profile' do
  it 'fails due to some error' do
    user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)

    login_as user

    allow_any_instance_of(Profile).to receive(:update).and_return(false)

    patch profiles_path, params: { profile: { about: 'New about me' } }

    expect(response.body).to include('Erro ao tentar alterar o perfil')
  end
end
