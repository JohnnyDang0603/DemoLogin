module DateTimeHelper
  def format_time_24h(time)
    time&.strftime('%H : %M')
  end

  def format_time_12h(time)
    time&.strftime('%H : %m, %p')
  end

  def format_date_normal(date)
    date&.strftime('%d - %m - %Y')
  end
end
