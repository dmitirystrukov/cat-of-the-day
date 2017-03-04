class DaySubjectsController < ApplicationController
  PER_PAGE = 9

  authorize_resource
  respond_to :html

  def index
    @day_subjects = DaySubject.page(params[:page]).per(PER_PAGE)
  end

  def show
    @day_subject  = DaySubject.find(params[:id])
    @social_posts = SocialProvider.collect_social_posts(@day_subject.social_posts.actively)
  end

  def new
    @day_subject = current_user.day_subjects.build
    @day_subject.day_subject_images.build
  end

  def create
    @day_subject = current_user.day_subjects.create(day_subject_params)
    flash[:notice] = I18n.t('day_subjects.create.success') if @day_subject.valid?

    respond_with @day_subject
  end

  def edit
    @day_subject = DaySubject.find(params[:id])
  end

  def update
    @day_subject = current_user.day_subjects.find(params[:id]).update(day_subject_params)
    flash[:notice] = I18n.t('day_subjects.update.success') if @day_subject.valid?

    respond_with @day_subject
  end

  def destroy
    @day_subject = current_user.day_subjects.find(params[:id]).destroy
    flash[:notice] = I18n.t('day_subjects.destroy.success')

    respond_with @day_subject
  end

  private

  def day_subject_params
    params.require(:day_subject).permit(:user_id, :title, :description, day_subject_images_attributes: [:url])
  end
end
