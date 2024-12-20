require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid' do
    it 'false when nickname is not present' do
      user = User.new(email: 'teste@gmail.com', password: '12345678')

      expect(user.valid?).to be false
      expect(user.errors.include?(:nickname)).to be true
    end

    it 'false when email is not present' do
      user = User.new(nickname: 'teste', email: '', password: '12345678')

      expect(user.valid?).to be false
      expect(user.errors.include?(:email)).to be true
    end

    it 'false when password is not present' do
      user = User.new(nickname: 'teste', email: 'teste@gmail.com', password: '')

      expect(user.valid?).to be false
      expect(user.errors.include?(:password)).to be true
    end


    it 'false when nickname already exists' do
      User.create!(nickname: 'teste', email: 'first@gmail.com', password: '12345678')
      user = User.new(nickname: 'teste', email: 'teste@gmail.com', password: '')

      expect(user.valid?).to be false
      expect(user.errors.include?(:nickname)).to be true
    end

    it 'false when nickname already exists with insensitive case' do
      User.create!(nickname: 'teste', email: 'first@gmail.com', password: '12345678')
      user = User.new(nickname: 'TESTE', email: 'second@gmail.com', password: '12345678')

      expect(user.valid?).to be false
      expect(user.errors.include?(:nickname)).to be true
    end
  end
end
