require 'rails_helper'

RSpec.describe Api::Public::ProfilesController, type: :controller do
  describe '#show' do
    let(:result) { JSON.parse(response.body) }

    subject { get :show, params }

    context 'when user nickname exists' do
      let(:nickname) { 'john-wayne' }

      let!(:user)  { create :user }
      let(:params) { { id: nickname, format: :json } }

      let(:data) do
        { 'first_name' => user.first_name, 'last_name' => user.last_name, 'location' => user.location }
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

      it 'return json' do
        subject

        expect(response.body).to eq 'null'
      end
    end
  end
end
