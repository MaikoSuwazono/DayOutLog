require 'rails_helper'

RSpec.describe PostDetail, type: :model do
  let(:post) { FactoryBot.create(:post) }
  
  describe 'バリデーション' do
    context 'すべてのカラム' do
      it '設定したすべてのバリデーションが機能しているか' do
        post_detail = FactoryBot.build(:post_detail, post: post)
        expect(post_detail).to be_valid
        expect(post_detail.errors).to be_empty
      end
    end

    context 'post_idカラム' do
      it 'post_idがない場合にバリデーションが機能してinvalidになるか' do
        post_detail_without_post_id = FactoryBot.build(:post_detail, post_id: "")
        expect(post_detail_without_post_id).to be_invalid
        expect(post_detail_without_post_id.errors[:post_id]).to eq ["を入力してください"]
      end
    end

    context 'bodyカラム' do
      it 'bodyがない場合にバリデーションが機能してinvalidになるか' do
        post_detail_without_body = FactoryBot.build(:post_detail, body: "", post: post)
        expect(post_detail_without_body).to be_invalid
        expect(post_detail_without_body.errors[:body]).to eq ["を入力してください"]
      end
    end

    context 'arrival_atカラム' do
      it 'arrival_atがない場合にバリデーションが機能してinvalidになるか' do
        post_detail_without_arrival_at = FactoryBot.build(:post_detail, arrival_at: "", post: post)
        expect(post_detail_without_arrival_at).to be_invalid
        expect(post_detail_without_arrival_at.errors[:arrival_at]).to eq ["を入力してください"]
      end
    end
  end
end
