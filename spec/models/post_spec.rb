require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe 'バリデーション' do
    context 'すべてのカラム' do
      it '設定したすべてのバリデーションが機能しているか' do
        post = FactoryBot.build(:post, user: user)
        expect(post).to be_valid
        expect(post.errors).to be_empty
      end
    end

    context 'user_idカラム' do
      it 'user_idがない場合にバリデーションが機能してinvalidになるか' do
        post_without_user_id = FactoryBot.build(:post, user_id: "")
        expect(post_without_user_id).to be_invalid
        expect(post_without_user_id.errors[:user_id]).to eq ["を入力してください"]
      end
    end

    context 'titleカラム' do
      it 'titleがない場合にバリデーションが機能してinvalidになるか' do
        post_without_title = FactoryBot.build(:post, title: "", user: user)
        expect(post_without_title).to be_invalid
        expect(post_without_title.errors[:title]).to eq ["を入力してください"]
      end
    end

    context 'departure_dateカラム' do
      it 'departure_dateがない場合にバリデーションが機能してinvalidになるか' do
        post_without_departure_date = FactoryBot.build(:post, departure_date: "", user: user)
        expect(post_without_departure_date).to be_invalid
        expect(post_without_departure_date.errors[:departure_date]).to eq ["を入力してください"]
      end

      it 'departure_dateが今日から前の日付であること: 今日の日付はOK' do
        post = FactoryBot.build(:post, departure_date: Date.today, user: user)
        expect(post).to be_valid
        expect(post.errors[:departure_date]).to be_empty
      end

      it 'departure_dateが今日から前の日付であること: 昨日の日付はOK' do
        post = FactoryBot.build(:post, departure_date: Date.yesterday, user: user)
        expect(post).to be_valid
        expect(post.errors[:departure_date]).to be_empty
      end

      it 'departure_dateが今日から前の日付であること: 明日の日付はNG' do
        post = FactoryBot.build(:post, departure_date: Date.tomorrow, user: user)
        expect(post).to be_invalid
        expect(post.errors[:departure_date]).to eq ["は今日より前の日付を入力してください"]
      end
    end

    context 'statusカラム' do
      it 'statusがない場合にバリデーションが機能してinvalidになるか' do
        post_without_status = FactoryBot.build(:post, status: "", user: user)
        expect(post_without_status).to be_invalid
        expect(post_without_status.errors[:status]).to eq ["を入力してください"]
      end

      it 'statusが0の場合、draftとして値が保存されるか' do
        post = FactoryBot.build(:post, status: 0, user: user)
        expect(post).to be_valid
        expect(post.errors[:status]).to be_empty
        expect(post.status).to eq 'draft'
      end

      it 'statusが1の場合、publishedとして値が保存されるか' do
        post = FactoryBot.build(:post, status: 1, user: user)
        expect(post).to be_valid
        expect(post.errors[:status]).to be_empty
        expect(post.status).to eq 'published'
      end
    end
  end
end
