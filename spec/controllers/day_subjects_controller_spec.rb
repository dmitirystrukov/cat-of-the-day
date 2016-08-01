require 'rails_helper'

RSpec.describe DaySubjectsController, type: :controller do
  let!(:day_subject) { create :day_subject }
  let!(:user) { create :user}

  before { sign_in user }

  describe '#index' do
    let!(:another_day_subject) { create :day_subject }

    subject { get :index }

    it 'assings the day_subjects' do
      subject
      expect(assigns(:day_subjects)).to eq [day_subject, another_day_subject]
    end

    it { is_expected.to render_template :index }
  end

  describe '#show' do
    let(:params) { { id: day_subject.id } }

    subject { get :show, params }

    it 'assigns the day_subject' do
      subject
      expect(assigns(:day_subject)).to eq day_subject
    end
  end

  describe '#new' do
    subject { get :new }

    it 'assings a new day_subject' do
      subject
      expect(assigns(:day_subject)).to be_a_new DaySubject
    end

    it { is_expected.to render_template :new }
  end

  describe '#create' do
    let(:params) { { day_subject: attributes_for(:day_subject) } }

    context 'when the params are valid' do
      subject { post :create, params }

      it 'creates a new day_subject' do
        expect { subject }.to change { DaySubject.count }.by(1)
        expect(assigns(:day_subject)).to eq DaySubject.last
        expect(subject).to redirect_to root_path
      end
    end

    context 'when the params are invalid' do
      let(:invalid_params) do
        params.tap { |hash| hash[:day_subject].update(title: 'a' * 41) }
      end

      subject { post :create, invalid_params }

      it 'tries to create a new day_subject' do
        expect { subject }.to change { DaySubject.count }.by(0)
      end

      it { is_expected.to render_template :new }
    end
  end

  describe '#destroy' do
    context 'when user is owner' do
      let!(:another_day_subject) { create :day_subject, user: user }

      subject { delete :destroy, id: another_day_subject.id }

      it 'deletes the day_subject' do
        expect { subject }.to change { DaySubject.count }.by(-1)
        expect(subject).to redirect_to root_path
      end
    end

    context 'when user is not owner' do
      subject { delete :destroy, id: day_subject.id }

      it 'tries to delete the day_subject' do
        expect { subject }.to change { DaySubject.count }.by(0)
        expect(subject).to redirect_to root_path
        expect(flash[:error]).to eq "You don't have permission"
      end
    end
  end
end
