require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'User作成' do
    context '正常系' do
      it '正常に入力した場合、Userが作成されること' do
        visit root_path
        visit new_user_path
        fill_in 'ユーザー名', with: 'foofoo'
        fill_in 'メールアドレス', with: 'foofoo@foo.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録'
        expect(page).to have_content '登録が完了しました。'
        expect(User.count).to eq 1
        expect(current_path).to eq login_path
      end
    end

    context '異常系' do
      it '入力内容が正しくない場合、Userが作成されないこと' do
        visit new_user_path
        fill_in 'ユーザー名', with: 'foo'
        fill_in 'メールアドレス', with: 'foo@foo.com'
        fill_in 'パスワード', with: ''
        fill_in 'パスワード', with: ''
        click_button '登録'
        expect(page).to have_content '登録に失敗しました。'
        expect(User.count).to eq 0
        # expect(current_path).to eq new_user_path
      end
    end
  end

  describe 'User編集' do
    let(:user) { create(:user) }
    context '正常系' do
      it '入力が正常な場合、userを編集できること' do
        login_as(user)
        visit edit_user_path(user)
        fill_in 'ユーザー名', with: 'test'
        click_button '更新'
        expect(page).to have_content 'ユーザー情報を更新しました。'
        expect(page).to have_content 'test'
        expect(current_path).to eq user_path(user)
      end
    end

    context '異常系' do
      it '入力内容が正しくない場合、userを編集できないこと' do
        login_as(user)
        visit edit_user_path(user)
        fill_in 'ユーザー名', with: ''
        click_button '更新'
        expect(page).to have_content 'ユーザー情報の更新に失敗しました。'
        expect(page).to have_content 'ユーザー名を入力してください'
      end
    end
  end
end
