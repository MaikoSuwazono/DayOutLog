require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    context 'すべてのカラム' do
      it '設定したすべてのバリデーションが機能しているか' do
        user = FactoryBot.build(:user)
        expect(user).to be_valid
        expect(user.errors).to be_empty
      end
    end

    context 'nameカラム' do
      it 'nameがない場合にバリデーションが機能してinvalidになるか' do
        user_without_name = FactoryBot.build(:user, name: " ")
        expect(user_without_name).to be_invalid
        expect(user_without_name.errors[:name]).to eq ["を入力してください", "は3文字以上で入力してください"] 
      end
      
      it 'nameが被った場合にuniqueのバリデーションが機能してinvalidになるか' do
        user = FactoryBot.create(:user)
        user_with_duplicated_name = FactoryBot.build(:user, name: user.name)
        expect(user_with_duplicated_name).to be_invalid
        expect(user_with_duplicated_name.errors[:name]).to eq ["はすでに存在します"]
      end

      it 'nameが3文字以上であること: 2文字はNG' do
        user = FactoryBot.build(:user, name: Faker::Lorem.characters(number: 2))
        expect(user).to be_invalid
        expect(user.errors[:name]).not_to be_empty
      end

      it 'nameが3文字以上であること: 3文字はOK' do
        user = FactoryBot.build(:user, name: Faker::Lorem.characters(number: 3))
        expect(user).to be_valid
        expect(user.errors[:name]).to be_empty
      end

      it 'nameが20文字以下であること: 21文字はNG' do
        user = FactoryBot.build(:user, name: Faker::Lorem.characters(number: 21))
        expect(user).to be_invalid
        expect(user.errors[:name]).not_to be_empty
      end

      it 'nameが20文字以下であること: 20文字はOK' do
        user = FactoryBot.build(:user, name: Faker::Lorem.characters(number: 20))
        expect(user).to be_valid
        expect(user.errors[:name]).to be_empty
      end
    end

    context 'emailカラム' do
      it 'emailがない場合にバリデーションが機能してinvalidになるか' do
        user_without_email = FactoryBot.build(:user, email: " ")
        expect(user_without_email).to be_invalid
        expect(user_without_email.errors[:email]).to eq ["を入力してください"]
      end
      
      it 'emailが被った場合にuniqueのバリデーションが機能してinvalidになるか' do
        user = FactoryBot.create(:user)
        user_with_duplicated_email = FactoryBot.build(:user, email: user.email)
        expect(user_with_duplicated_email).to be_invalid
        expect(user_with_duplicated_email.errors[:email]).to eq ["はすでに存在します"]
      end
    end

    context 'passwordカラム' do
      it 'passwordない場合にバリデーションが機能してinvalidになるか' do
        user_without_password = FactoryBot.build(:user, password: " ")
        expect(user_without_password).to be_invalid
        expect(user_without_password.errors[:password]).to eq ["は8文字以上で入力してください"]
      end
      
      it 'passwordが8文字以上であること: 7文字はNG' do
        user = FactoryBot.build(:user, password: Faker::Lorem.characters(number: 7))
        expect(user).to be_invalid
        expect(user.errors[:password]).not_to be_empty
      end

      it 'passwordが8文字以上であること: 8文字はOK' do
        password = Faker::Lorem.characters(number: 8)
        user = FactoryBot.build(:user, password: password, password_confirmation: password)
        expect(user).to be_valid
        expect(user.errors[:password]).to be_empty
      end

      it 'passwordが20文字以下であること: 21文字はNG' do
        password = Faker::Lorem.characters(number: 21)
        user = FactoryBot.build(:user, password: password, password_confirmation: password)
        expect(user).to be_invalid
        expect(user.errors[:password]).not_to be_empty
      end

      it 'passwordが20文字以下であること: 20文字はOK' do
        password = Faker::Lorem.characters(number: 20)
        user = FactoryBot.build(:user, password: password, password_confirmation: password)
        expect(user).to be_valid
        expect(user.errors[:password]).to be_empty
      end

      it 'passwordを入力していてもpassword_confirmationを入力していない場合にバリデーションが機能してinvalidになるか' do
        user = FactoryBot.build(:user, password_confirmation: "")
        expect(user).to be_invalid
        expect(user.errors[:password_confirmation]).not_to be_empty
      end
      
      it 'passwordとpassword_confirmationが一致していない場合にバリデーションが機能してinvalidになるか' do
        user = FactoryBot.build(:user, password: Faker::Lorem.characters(number: 8), password_confirmation: Faker::Lorem.characters(number: 9))
        expect(user).to be_invalid
        expect(user.errors[:password_confirmation]).not_to be_empty
      end
    end
  end
end
