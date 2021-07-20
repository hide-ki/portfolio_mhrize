require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it 'name,email,password,password_confirmationを正常に入力すれば有効であること' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'user名が未入力の場合失敗する' do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include('を入力してください')
    end

    it 'emailが未入力の場合失敗する' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
    end

    it 'emailが重複しているなら無効であること' do
      @user = User.create(
        name: 'hoge',
        email: 'hoge@hoge.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user = build(:user, email: 'hoge@hoge.com')
      user.valid?
      expect(user.errors[:email]).to include('はすでに存在します')
    end

    it 'passwordが未入力の場合無効であること' do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include('は8文字以上で入力してください')
    end

    it 'password_confirmationが未入力の場合無効であること' do
      user = build(:user, password_confirmation: nil)
      user.valid?
      expect(user.errors[:password_confirmation]).to include('を入力してください')
    end
  end
end
