require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    it 'nameが空では登録できない' do
      user = User.new(name: '', email: 'test@example', password: '000000', password_confirmation: '000000')
      user.valid?
      expect(user.errors.full_messages).to include("Name ：名前を入力してください")
    end
    
    it 'emailが空では登録できない' do
      user = User.new(name: 'test', email: '', password: '000000', password_confirmation: '000000')
      user.valid?
      expect(user.errors.full_messages).to include("Email ：メールアドレスを入力してください")
    end

    it 'nameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
      user = User.new(name: 'test', email: 'test@example.com', password: '000000', password_confirmation: '000000')
      expect(user).to be_valid
    end

    it 'passwordが空では登録できない' do
      user = User.new(name: 'test', email: 'test@example.com', password: '', password_confirmation: '')
      user.valid?
      expect(user.errors.full_messages).to include("Password ：パスワードを入力してください")
    end

    it 'passwordとpassword_confirmationが不一致では登録できない' do
      user = User.new(name: 'test', email: 'test@example.com', password: '000000', password_confirmation: '123456')
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include("Password confirmation ：確認用パスワードとパスワードが一致しません")
    end

    it '重複したemailが存在する場合は登録できない' do
      User.create(name: 'existing_user', email: 'test@example.com', password: '000000', password_confirmation: '000000')
      user = User.new(name: 'new_user', email: 'test@example.com', password: '123456', password_confirmation: '123456')
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include("Email ：このメールアドレスは既に使用されています")
    end

    it 'emailは@を含まないと登録できない' do
      user = User.new(name: 'test', email: 'testexample.com', password: '000000', password_confirmation: '000000')
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include("Email は不正な値です")
    end

    it 'passwordが5文字以下では登録できない' do
      user = User.new(name: 'test', email: 'test@example.com', password: '1234', password_confirmation: '1234')
      user.valid?
      expect(user.errors.full_messages).to include("Password ：パスワードは6文字以上で入力してください")
    end

    it 'passwordが129文字以上では登録できない' do
      user = User.new(name: 'test', email: 'test@example.com', password: 'a' * 129, password_confirmation: 'a' * 129)
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include("Password ：は128文字以内で入力してください")
    end

  end
end
