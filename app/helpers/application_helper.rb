module ApplicationHelper

  def format_datetime(dt)
    dt.strftime("%v")
  end

end
