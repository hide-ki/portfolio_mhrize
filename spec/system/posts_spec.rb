require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:post) { create(:post, user: user) }

  describe 'Post作成' do
    context '正常系' do
      it '入力内容が正常なら、postが作成できること' do
        login_as(user)
        click_link '投稿'
        attach_file '重ね着画像', "#{Rails.root}/spec/fixtures/peach-1.jpg"
        click_button '投稿'
        expect(page).to have_content '投稿が作成されました。'
        expect(current_path).to eq root_path
        # 画像にalt属性またはidをつけたら画像が表示されていることを確認する
        expect(page).to have_selector("img[src$='peach-1.jpg']")
      end
    end
    context '異常系' do
      it '入力内容が正しくない場合、postが作成されないこと' do
        login_as(user)
        click_link '投稿'
        click_button '投稿'
        expect(page).to have_content '投稿に失敗しました。'
        expect(page).to have_content '重ね着画像を入力してください'
      end
    end
  end

  describe 'Post詳細' do
    context '正常系' do
      it 'postの詳細を表示できること' do
        login_as(user)
        post
        visit root_path
        # imageにclassを指定しているので、classを見つけてクリックさせている
        find('.post_image').click
        expect(page).to have_content '装備詳細'
        expect(current_path).to eq post_path(post)
      end
    end
  end
  describe 'Post編集' do
    context 'postのユーザーが同一な場合' do
      it '編集ページにアクセスできること' do
        login_as(user)
        post
        visit root_path
        find('.post_image').click
        click_link '編集'
        expect(page).to have_content '装備編集'
        expect(current_path).to eq edit_post_path(post)
      end
    end

    context 'postのユーザーが別のユーザーの場合' do
      it '編集ページではなくroot_pathに遷移すること' do
        user
        post
        login_as(other_user)
        visit root_path
        find('.post_image').click
        visit edit_post_path(post)
        expect(current_path).to eq root_path
      end
    end
  end
end
