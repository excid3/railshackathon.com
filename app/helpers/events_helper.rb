module EventsHelper
  def event_date_info(event)
    event_start_tag = content_tag(:time, event_time_formatter(event.start_time), datetime: event_html_attrs(event.start_time))
    event_end_tag = content_tag(:time, event_time_formatter(event.end_time), datetime: event_html_attrs(event.end_time))
    final_tag = event_start_tag + " - " + event_end_tag
  end

  def ordinalize_event_datetime(event_datetime)
    converted = event_datetime.in_time_zone("Central Time (US & Canada)")
    converted.strftime("%B #{converted.day.ordinalize} at%l %p #{converted.zone}")
  end

  def event_time_formatter(event_datetime)
    event_datetime.in_time_zone("Central Time (US & Canada)").strftime("%B %d")
  end

  def event_html_attrs(event_datetime)
     event_datetime.in_time_zone("Central Time (US & Canada)").strftime("%Y-%m-%d")
  end

  def countdown(time, prefix:)
    tag.span data: { controller: "countdown", countdown_date_value: time, countdown_prefix_value: prefix }
  end
end
