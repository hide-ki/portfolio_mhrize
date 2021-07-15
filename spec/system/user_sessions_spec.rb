require 'rails_helper'

RSpec.describe 'UserSessions', type: :system do
  let(:user) { create(:user) }

  describe 'ログイン機能' do
    before do
      visit login_path
    end
    context '正常系' do
      it 'ログイン情報が正常な場合、ログインできること' do
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました。'
        expect(current_path).to eq root_path
      end
    end

    context '異常系' do
      it 'ログイン情報が正常ではない場合、ログインに失敗すること' do
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインに失敗しました。'
        expect(current_path).to eq login_path
      end
      it 'passwordが異なる場合、ログインできないこと' do
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'possword'
        click_button 'ログイン'
        expect(page).to have_content 'ログインに失敗しました。'
        expect(current_path).to eq login_path
      end
      it 'emailが異なる場合、ログインできないこと' do
        user
        fill_in 'メールアドレス', with: 'test@test.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインに失敗しました。'
        expect(current_path).to eq login_path
      end
    end
  end
  describe 'ログアウト機能' do
    context '正常系' do
      xit 'ログアウトできること' do
        login_as(user)
        expect(current_path).to eq login_path
      end
    end
  end
end
