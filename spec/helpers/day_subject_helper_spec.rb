require 'rails_helper'

RSpec.describe DaySubjectHelper, type: :helper do
  describe '#styles' do
    let(:current_user) { create :user }

    let(:owner_styles) do
      { class: 'style8', image: 'owner_block.jpg' }
    end

    let(:viewer_styles) do
      { class: 'style2', image: 'viewer_block.jpg' }
    end

    before { sign_in current_user }

    subject { styles(day_subject) }

    context 'when current user owner of day subject' do
      let(:day_subject)  { create :day_subject, user: current_user }

      it 'should return owner styles' do
        expect(subject).to eq owner_styles
      end
    end

    context 'when current user not owner of day subject' do
      let(:another_user) { create :user }
      let(:day_subject)  { create :day_subject, user: another_user }

      it 'should return viewer styles' do
        expect(subject).to eq viewer_styles
      end
    end
  end
end
