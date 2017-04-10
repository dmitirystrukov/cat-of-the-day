require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when creating new user with role' do
    let(:selected_role) { :client }
    let(:user) { build :user, selected_role: selected_role }

    subject { user.save }

    it 'should create with client role' do
      expect { subject }.to change { Role.count }.by(1)

      expect(user.reload.roles.first.name).to eq 'client'
    end

    context 'when selected role is blank' do
      let(:selected_role) { '' }

      it { expect { subject }.to change { Role.count }.by(0) }
    end
  end
end
