require 'rails_helper'

RSpec.describe Api::Public::NicknameValidationController, type: :controller do
  describe '#validate' do
    let(:result) { JSON.parse(response.body) }

    subject { get :validate, params }

    context 'when user nickname exists' do
      let(:nickname) { 'john-wayne' }

      let!(:user)  { create :user }
      let(:params) { { id: nickname, format: :json } }

      let(:data) do
        { 'result' => true, 'message' => 'Nickname already in use' }
      end

      before do
        user.profile.update(nickname: nickname)
      end

      it 'return json' do
        subject

        expect(result).to eq data
      end
    end

    context 'when user nickname not exists' do
      let(:params) { { id: 'somenickname', format: :json } }

      let(:data) do
        { 'result' => false, 'message' => 'Nickname is not used' }
      end

      it 'return json' do
        subject

        expect(result).to eq data
      end
    end
  end
end
