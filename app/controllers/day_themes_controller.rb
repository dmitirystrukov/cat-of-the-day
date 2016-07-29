class DayThemesController < ActionController::Base
  before_action :authenticate_user!, only: [:new, :create, :destroy]

  def index
    @day_themes = DayTheme.all
  end

  def show
    @day_theme = DayTheme.find(params[:id])
  end

  def new
    @day_theme = current_user.day_themes.build
  end

  def create
    @day_theme = current_user.day_themes.build(day_theme_params)

    if @day_theme.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @day_theme = DayTheme.find(params[:id])

    if @day_theme.owner?(current_user)
      @day_theme.destroy

      redirect_to root_path
    else
      redirect_to root_path, flash: { error: "You don't have permission" }
    end
  end

  def day_theme_params
    params.require(:day_theme).permit(:user_id, :title, :description)
  end
end
