require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'User作成' do
    let(:user) { create(:user) }
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
      end
      it 'emailが重複した場合、登録できないこと' do
        visit new_user_path
        fill_in 'ユーザー名', with: 'foo'
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録'
        expect(page).to have_content 'メールアドレスはすでに存在します'
      end
      it 'パスワードとパスワード確認が一致しない場合、登録できないこと' do
        visit new_user_path
        fill_in 'ユーザー名', with: 'foofoo'
        fill_in 'メールアドレス', with: 'foofoo@foo.com'
        fill_in 'パスワード', with: 'hogehoge'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録'
        expect(page).to have_content 'パスワード確認とパスワードの入力が一致しません'
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

  describe 'User削除' do
    let(:user) { create(:user) }
    context '正常系' do
      it 'ユーザーを削除できること' do
        login_as(user)
        visit user_path(user)
        click_link '削除'
        expect(page.accept_confirm).to eq '削除してもよろしいですか？'
        expect(page).to have_content 'ユーザーを削除しました。'
        expect(current_path).to eq new_user_path
      end
    end
    context '確認ダイアログでキャンセルを押した場合' do
      it 'ユーザーを削除できないこと' do
        login_as(user)
        visit user_path(user)
        click_link '削除'
        expect(page.dismiss_confirm).to eq '削除してもよろしいですか？'
        expect(current_path).to eq user_path(user)
        expect(User.count).to eq 1
      end
    end
  end
end
