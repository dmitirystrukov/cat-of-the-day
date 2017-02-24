require 'rails_helper'

RSpec.describe DaySubjectsController, type: :controller do
  let(:user) { create :user }

  before do
    user.add_role :client
    sign_in user
  end

  describe '#index' do
    let!(:day_subject_1) { create :day_subject }
    let!(:day_subject_2) { create :day_subject }

    before { subject }

    subject { get :index }

    it 'sort order' do
      expect(assigns(:day_subjects)).to eq [day_subject_1, day_subject_2]
      expect(subject).to render_template :index
    end
  end

  describe '#show' do
    let(:day_subject) { create :day_subject }

    before { subject }

    subject { get :show, id: day_subject.id }

    it 'verify day subject' do
      expect(assigns(:day_subject)).to eq day_subject
      expect(subject).to render_template :show
    end
  end

  describe '#new' do
    subject { get :new }

    before { subject }

    it 'verify day subject' do
      expect(assigns(:day_subject)).to be_a_new DaySubject
      expect(subject).to render_template :new
    end
  end

  describe '#create' do
    let(:day_subject) { build :day_subject }
    let(:params) { { day_subject: attributes_for(:day_subject) } }

    context 'when uploading multiply images' do
      let(:image_1) { Rack::Test::UploadedFile.new(File.open('spec/fixtures/pixel.jpg')) }
      let(:image_2) { Rack::Test::UploadedFile.new(File.open('spec/fixtures/cat.jpg')) }

      let(:params) do
        {
          day_subject: {
            title: day_subject.title,
            description: day_subject.description,
            day_subject_images_attributes: { '1' => { url: image_1 }, '2' => { url: image_2 } }
          }
        }
      end

      subject { post :create, params }

      specify do
        expect { subject }.to change { DaySubjectImage.count }.by(2)
        expect(subject).to redirect_to root_path
      end
    end

    context 'when params are valid' do
      subject { post :create, params }

      specify do
        expect { subject }.to change { DaySubject.count }.by(1)
        expect(assigns(:day_subject)).to eq DaySubject.last
        expect(subject).to redirect_to root_path
      end
    end

    context 'when params are invalid' do
      let(:invalid_params) do
        params.tap { |hash| hash[:day_subject].update(title: 'a' * 41) }
      end

      subject { post :create, invalid_params }

      specify do
        expect { subject }.to change { DaySubject.count }.by(0)
        is_expected.to render_template :new
      end
    end
  end

  describe '#destroy' do
    let!(:day_subject_1) { create :day_subject, user: user }
    let!(:day_subject_2) { create :day_subject }

    subject { delete :destroy, params }

    context 'when user is owner' do
      let(:params) { { id: day_subject_1.id } }

      specify do
        expect { subject }.to change { DaySubject.count }.by(-1)
        expect(subject).to redirect_to root_path
      end
    end

    context 'when user in not owner' do
      let(:params) { { id: day_subject_2.id } }

      specify do
        expect { subject }.to change { DaySubject.count }.by(0)
        expect(subject).to redirect_to root_path
        expect(flash[:error]).to eq "You don't have permission"
      end
    end
  end
end
