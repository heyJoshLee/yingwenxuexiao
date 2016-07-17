module ApplicationHelper

  def format_datetime(dt)
    dt.strftime("%m/%d/%Y %I:%M%P")
  end

end
