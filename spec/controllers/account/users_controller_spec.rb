require 'rails_helper'

RSpec.describe Account::UsersController, type: :controller do
  let(:owner_user)   { create :user, :with_role, user_role: :consumer }
  let(:another_user) { create :user, :with_role, user_role: :consumer }

  describe '#edit' do
    let(:params) { { id: owner_user.profile.to_param } }

    subject { get :edit, params }

    context 'when editing own profile' do
      before { sign_in owner_user }

      it { expect { subject }.to_not raise_error CanCan::AccessDenied }
    end

    context 'when editing not own profile' do
      before { sign_in another_user }

      it { expect { subject }.to raise_error CanCan::AccessDenied }
    end
  end

  describe '#update' do
    let(:user_params) { { profile_attributes: { first_name: 'John' } } }
    let(:params)      { { id: owner_user.profile.to_param, user: user_params } }

    subject { patch :update, params }

    context 'when updating own profile' do
      before { sign_in owner_user }

      it { expect { subject }.to change { owner_user.profile.reload.first_name }.to eq 'John' }
    end

    context 'when updating not own profile' do
      before { sign_in another_user }

      it { expect { subject }.to raise_error CanCan::AccessDenied }
    end
  end
end
