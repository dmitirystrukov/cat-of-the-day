class DaySubjectsController < ApplicationController
  PER_PAGE = 9

  authorize_resource
  respond_to :html

  before_action :current_namespace, only: :show

  def index
    @day_subjects = DaySubject.page(params[:page]).per(PER_PAGE)
  end

  def show
    @day_subject  = DaySubject.find(params[:id])
    @social_posts = social_posts

    render "day_subjects/#{current_namespace}/show"
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

  def social_posts
    case current_namespace.to_sym
    when :consumer
      SocialProvider.collect_social_posts(current_user, @day_subject.to_param)
    when :client
      @day_subject.social_posts.actively
    end
  end

  def current_namespace
    current_user.present? ? current_user.role.name : :guest
  end

  def day_subject_params
    params.require(:day_subject).permit(:user_id, :title, :description, day_subject_images_attributes: [:url])
  end
end
