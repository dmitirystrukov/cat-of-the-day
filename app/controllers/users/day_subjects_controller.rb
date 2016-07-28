class Users::DaySubjectsController < Users::BaseController
  PER_PAGE = 10

  def index
    @day_subjects = current_user.day_subjects.all.page(params[:page]).per(params[:per_page] || PER_PAGE)
  end

  def show
    @day_subject = current_user.day_subjects.find(params[:id])
  end

  def new
    @day_subject = current_user.day_subjects.build
  end

  def create
    @day_subject = current_user.day_subjects.build(day_subject_params)

    if @day_subject.save!
      redirect_to users_day_subject_path(id: day_subject_params.id)
    else
      render :new
    end
  end

  def destroy
    @day_subject.destroy
  end

  private

  def day_subject_params
    params.require(:day_subject).permit(:name, :picture, :description)
  end
end
