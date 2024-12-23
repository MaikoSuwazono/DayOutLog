require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成が成功する' do
          user = FactoryBot.build(:user)
          visit new_user_path
          fill_in 'ユーザー名 [必須]', with: user.name
          fill_in 'メールアドレス [必須]', with: user.email
          fill_in 'パスワード [必須]', with: 'password'
          fill_in 'パスワード確認 [必須]', with: 'password'
          image_path = Rails.root.join('app/assets/images/DayOutLog.png')
          click_button '登録'
          expect(page).to have_content 'ユーザー登録が完了しました'
          expect(current_path).to eq posts_path
        end
      end

      context 'ユーザー名が未入力' do
        it 'ユーザーの新規作成が失敗する' do
          user = FactoryBot.build(:user)
          visit new_user_path
          fill_in 'ユーザー名 [必須]', with: ''
          fill_in 'メールアドレス [必須]', with: user.email
          fill_in 'パスワード [必須]', with: 'password'
          fill_in 'パスワード確認 [必須]', with: 'password'
          image_path = Rails.root.join('app/assets/images/DayOutLog.png')
          click_button '登録'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content "ユーザー名を入力してください"
          expect(page).to have_content "ユーザー名は3文字以上で入力してください"
          expect(current_path).to eq new_user_path
        end
      end

      context '登録済のユーザー名を使用' do
        it 'ユーザーの新規作成が失敗する' do
          user = FactoryBot.create(:user)
          visit new_user_path
          fill_in 'ユーザー名 [必須]', with: user.name
          fill_in 'メールアドレス [必須]', with: user.email
          fill_in 'パスワード [必須]', with: 'password'
          fill_in 'パスワード確認 [必須]', with: 'password'
          image_path = Rails.root.join('app/assets/images/DayOutLog.png')
          click_button '登録'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content "ユーザー名はすでに存在します"
          expect(current_path).to eq new_user_path
        end
      end

      context 'メールアドレスが未入力' do
        it 'ユーザーの新規作成が失敗する' do
          user = FactoryBot.build(:user)
          visit new_user_path
          fill_in 'ユーザー名 [必須]', with: user.name
          fill_in 'メールアドレス [必須]', with: ''
          fill_in 'パスワード [必須]', with: 'password'
          fill_in 'パスワード確認 [必須]', with: 'password'
          image_path = Rails.root.join('app/assets/images/DayOutLog.png')
          click_button '登録'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content "メールアドレスを入力してください"
          expect(current_path).to eq new_user_path
        end
      end

      context '登録済のメールアドレスを使用' do
        it 'ユーザーの新規作成が失敗する' do
          user = FactoryBot.create(:user)
          visit new_user_path
          fill_in 'ユーザー名 [必須]', with: user.name
          fill_in 'メールアドレス [必須]', with: user.email
          fill_in 'パスワード [必須]', with: 'password'
          fill_in 'パスワード確認 [必須]', with: 'password'
          image_path = Rails.root.join('app/assets/images/DayOutLog.png')
          click_button '登録'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content "メールアドレスはすでに存在します"
          expect(current_path).to eq new_user_path
        end
      end
    end

    context 'パスワードが未入力' do
      it 'ユーザーの新規作成が失敗する' do
        user = FactoryBot.build(:user)
        visit new_user_path
        fill_in 'ユーザー名 [必須]', with: user.name
        fill_in 'メールアドレス [必須]', with: user.email
        fill_in 'パスワード [必須]', with: ''
        fill_in 'パスワード確認 [必須]', with: 'password'
        image_path = Rails.root.join('app/assets/images/DayOutLog.png')
        click_button '登録'
        expect(page).to have_content 'ユーザー登録に失敗しました'
        expect(page).to have_content "パスワードは8文字以上で入力してください"
        expect(page).to have_content "パスワード確認とパスワードの入力が一致しません"
        expect(current_path).to eq new_user_path
      end
    end

    context 'パスワード確認が未入力' do
      it 'ユーザーの新規作成が失敗する' do
        user = FactoryBot.build(:user)
        visit new_user_path
        fill_in 'ユーザー名 [必須]', with: user.name
        fill_in 'メールアドレス [必須]', with: user.email
        fill_in 'パスワード [必須]', with: 'password'
        fill_in 'パスワード確認 [必須]', with: ''
        image_path = Rails.root.join('app/assets/images/DayOutLog.png')
        click_button '登録'
        expect(page).to have_content 'ユーザー登録に失敗しました'
        expect(page).to have_content "パスワード確認を入力してください"
        expect(current_path).to eq new_user_path
      end
    end

    context 'パスワードとパスワード確認が不一致' do
      it 'ユーザーの新規作成が失敗する' do
        user = FactoryBot.build(:user)
        visit new_user_path
        fill_in 'ユーザー名 [必須]', with: user.name
        fill_in 'メールアドレス [必須]', with: user.email
        fill_in 'パスワード [必須]', with: 'password'
        fill_in 'パスワード確認 [必須]', with: 'passworddd'
        image_path = Rails.root.join('app/assets/images/DayOutLog.png')
        click_button '登録'
        expect(page).to have_content 'ユーザー登録に失敗しました'
        expect(page).to have_content "パスワード確認とパスワードの入力が一致しません"
        expect(current_path).to eq new_user_path
      end
    end

    describe 'マイページ' do
      context 'ログインしていない状態' do
        it 'マイページへのアクセスが失敗する' do
          user = FactoryBot.create(:user)
          visit user_path(user)
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq login_path
        end
      end
    end
  end

  describe 'ログイン後' do
    avatar = Rack::Test::UploadedFile.new(Rails.root.join('app/assets/images/girl.png'), 'image/png')

    describe 'ユーザー編集' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集が成功する' do
          user = User.create(name: 'testuser1', email: 'testuser1@example.com', password: 'password', password_confirmation: 'password', avatar: avatar)          
          login_as(user)
          sleep 3
          visit edit_user_path(user)
          fill_in 'ユーザー名 [必須]', with: 'updateuser1'
          fill_in 'メールアドレス [必須]', with: 'update1@example.com'
          image_path = Rails.root.join('app/assets/images/DayOutLog.png')
          attach_file('プロフィール画像', image_path, make_visible: true )
          click_button '変更'
          expect(page).to have_content('ユーザーを更新しました')
          expect(current_path).to eq user_path(user)
        end
      end

      context 'ユーザー名が未入力' do
        it 'ユーザーの編集が失敗する' do
          user = User.create(name: 'testuser2', email: 'testuser2@example.com', password: 'password', password_confirmation: 'password', avatar: avatar)
          login_as(user)
          sleep 3
          visit edit_user_path(user)
          fill_in 'ユーザー名 [必須]', with: ''
          fill_in 'メールアドレス [必須]', with: 'update2@example.com'
          image_path = Rails.root.join('app/assets/images/DayOutLog.png')
          attach_file('プロフィール画像', image_path, make_visible: true )
          click_button '変更'
          expect(page).to have_content('ユーザーの更新に失敗しました')
          expect(page).to have_content "ユーザー名を入力してください"
          expect(page).to have_content "ユーザー名は3文字以上で入力してください"
          expect(current_path).to eq edit_user_path(user)
        end
      end

      context '登録済のユーザー名を使用' do
        it 'ユーザーの編集が失敗する' do
          user = User.create(name: 'testuser3', email: 'testuser3@example.com', password: 'password', password_confirmation: 'password', avatar: avatar)
          other_user = User.create(name: 'testuser4', email: 'testuser4@example.com', password: 'password', password_confirmation: 'password', avatar: avatar)
          login_as(user)
          sleep 3
          visit edit_user_path(user)
          fill_in 'ユーザー名 [必須]', with: other_user.name
          fill_in 'メールアドレス [必須]', with: 'update3@example.com'
          image_path = Rails.root.join('app/assets/images/DayOutLog.png')
          attach_file('プロフィール画像', image_path, make_visible: true )
          click_button '変更'
          expect(page).to have_content('ユーザーの更新に失敗しました')
          expect(page).to have_content "ユーザー名はすでに存在します"
          expect(current_path).to eq edit_user_path(user)
        end
      end
      
      context 'メールアドレスが未入力' do
        it 'ユーザーの編集が失敗する' do
          user = User.create(name: 'testuser5', email: 'testuser5@example.com', password: 'password', password_confirmation: 'password', avatar: avatar)
          login_as(user)
          sleep 3
          visit edit_user_path(user)
          fill_in 'ユーザー名 [必須]', with: 'updateuser5'
          fill_in 'メールアドレス [必須]', with: ''
          image_path = Rails.root.join('app/assets/images/DayOutLog.png')
          attach_file('プロフィール画像', image_path, make_visible: true )
          click_button '変更'
          expect(page).to have_content('ユーザーの更新に失敗しました')
          expect(page).to have_content "メールアドレスを入力してください"
          expect(current_path).to eq edit_user_path(user)
        end
      end

      context '登録済のメールアドレスを使用' do
        it 'ユーザーの編集が失敗する' do
          user = User.create(name: 'testuser6', email: 'testuser6@example.com', password: 'password', password_confirmation: 'password', avatar: avatar)
          other_user = User.create(name: 'testuser7', email: 'testuser7@example.com', password: 'password', password_confirmation: 'password', avatar: avatar)
          login_as(user)
          sleep 3
          visit edit_user_path(user)
          fill_in 'ユーザー名 [必須]', with: 'updateuser6'
          fill_in 'メールアドレス [必須]', with: other_user.email
          image_path = Rails.root.join('app/assets/images/DayOutLog.png')
          attach_file('プロフィール画像', image_path, make_visible: true )
          click_button '変更'
          expect(page).to have_content('ユーザーの更新に失敗しました')
          expect(page).to have_content "メールアドレスはすでに存在します"
          expect(current_path).to eq edit_user_path(user)
        end
      end
  
      context '他ユーザーの編集ページにアクセス' do
        it '編集ページへのアクセスが失敗する' do
          user = User.create(name: 'testuser11', email: 'testuser11@example.com', password: 'password', password_confirmation: 'password', avatar: avatar)
          other_user = User.create(name: 'testuser12', email: 'testuser12@example.com', password: 'password', password_confirmation: 'password', avatar: avatar)
          login_as(user)
          sleep 3
          visit edit_user_path(other_user)
          expect(page).to have_content 'ログインしてください'
          expect(current_path).to eq login_path
        end
      end
    end
  end
end
