require "rails_helper"

RSpec.describe "UserSessions", type: :system do
  let!(:user) { FactoryBot.create(:user) }

  describe 'ログイン前' do
    context 'フォームの入力値が正常' do
      it 'userインスタンスが有効であること' do
        expect(user).to be_valid
      end

      it 'ログイン処理が成功する' do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインに成功しました'
        expect(current_path).to eq posts_path
      end
    end

    context 'フォームが未入力' do
      it 'ログイン処理が失敗する' do
        visit login_path
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインに失敗しました'
        expect(current_path).to eq login_path
      end
    end
  end

  describe 'ログイン後' do
    context 'ログアウトボタンをクリック' do
      it 'ログアウト処理が成功する' do
        login_as(user)
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウト'
        expect(current_path).to eq root_path
      end
    end
  end
end