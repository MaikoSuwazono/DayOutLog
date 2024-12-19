require 'rails_helper'

RSpec.describe Authentication, type: :model do
  let(:user) { FactoryBot.create(:user) }
  
  describe 'バリデーション' do
    context 'すべてのカラム' do
      it '設定したすべてのバリデーションが機能しているか' do
        authentication = FactoryBot.build(:authentication, user: user)
        expect(authentication).to be_valid
        expect(authentication.errors).to be_empty
      end
    end

    context 'user_idカラム' do
      it 'user_idがない場合にバリデーションが機能してinvalidになるか' do
        authentication_without_user_id = FactoryBot.build(:authentication, user_id: "")
        expect(authentication_without_user_id).to be_invalid
        expect(authentication_without_user_id.errors[:user_id]).to eq ["を入力してください"]
      end
    end

    context 'providerカラム' do
      it 'providerがない場合にバリデーションが機能してinvalidになるか' do
        authentication_without_provider = FactoryBot.build(:authentication, provider: "")
        expect(authentication_without_provider).to be_invalid
        expect(authentication_without_provider.errors[:provider]).to eq ["を入力してください"]
      end
    end

    context 'uidカラム' do
      it 'uidがない場合にバリデーションが機能してinvalidになるか' do
        authentication_without_uid = FactoryBot.build(:authentication, uid: "")
        expect(authentication_without_uid).to be_invalid
        expect(authentication_without_uid.errors[:uid]).to eq ["を入力してください"]
      end
    end
  end
end
