module DaySubjectHelper
  def styles(day_subject)
    day_subject.owner?(current_user) ? owner_styles : viewer_styles
  end

  private
    def owner_styles
      { class: 'style8', image: 'pic10.jpg' }
    end

    def viewer_styles
      { class: 'style2', image: 'pic02.jpg' }
    end
end
