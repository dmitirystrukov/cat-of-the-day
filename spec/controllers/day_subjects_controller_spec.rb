require 'rails_helper'

RSpec.describe DaySubjectsController, type: :controller do
  let(:consumer) { create :user, :with_role, user_role: :consumer }
  let(:client)   { create :user, :with_role, user_role: :client }

  describe '#index' do
    subject { get :index }

    it { is_expected.to render_template :index }
  end

  describe '#new' do
    subject { get :new }

    context 'when user has role consumer' do
      before { sign_in consumer }

      it { expect { subject }.to raise_error CanCan::AccessDenied }
    end

    context 'when user has role client' do
      before { sign_in client }

      it { is_expected.to render_template :new }
    end
  end

  describe '#create' do
    let(:day_subject) { build :day_subject, user: client }
    let(:params)      { { day_subject: day_subject.attributes.compact } }

    subject { post :create, params }

    context 'when consumer trying to create day subject' do
      before { sign_in consumer }

      it 'can not delete day subject' do
        expect { subject }.to raise_error CanCan::AccessDenied
      end
    end

    context 'when creating day subject' do
      before { sign_in client }

      it 'create day subject' do
        expect { subject }.to change { DaySubject.count }.by(1)
         .and change { client.reload.day_subjects.count }.by(1)

        expect(flash[:notice]).to eq I18n.t('day_subjects.create.success')
      end
    end
  end

  describe '#destroy' do
    let(:day_subject) { create :day_subject, user: client }
    let(:params)      { { id: day_subject.id } }

    subject { delete :destroy, params }

    context 'when consumer deleting day subject' do
      before { sign_in consumer }

      it 'can not delete day subject' do
        expect { subject }.to raise_error CanCan::AccessDenied
      end
    end

    context 'when deleting own day subject' do
      before { sign_in client }

      it 'delete day subject' do
        subject

        expect(client.day_subjects).to eq []
        expect(flash[:notice]).to eq I18n.t('day_subjects.destroy.success')
      end
    end

    context 'when deleting not own day subject' do
      let(:another_client) { create :user, :with_role, user_role: :client }

      before { sign_in another_client }

      it 'can not delete day subject' do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end

  end

end
