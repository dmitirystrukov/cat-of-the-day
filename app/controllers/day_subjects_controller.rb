class DaySubjectsController < ApplicationController
  authorize_resource

  PER_PAGE = 9

  def index
    @day_subjects = DaySubject.page(params[:page]).per(PER_PAGE)
  end

  def edit
    @day_subject = DaySubject.find(params[:id])
  end

  def show
    @day_subject = DaySubject.find(params[:id])
  end

  def new
    @day_subject = current_user.day_subjects.build
  end

  def create
    @day_subject = current_user.day_subjects.build(day_subject_params)

    if @day_subject.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @day_subject = DaySubject.find(params[:id])

    if @day_subject.owner?(current_user)
      @day_subject.destroy

      redirect_to root_path
    else
      redirect_to root_path, flash: { error: "You don't have permission" }
    end
  end

  private

  def day_subject_params
    params.require(:day_subject).permit(:user_id, :title, :description, { images: [] })
  end
end
