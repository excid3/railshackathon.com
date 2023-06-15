module EventsHelper
  def event_date_info(event)
    event_start_tag = content_tag(:time, event_start(event), datetime: event_html_attrs(event.start_time))
    event_end_tag = content_tag(:time, event_end(event), datetime: event_html_attrs(event.end_time))
    final_tag = event_start_tag + " - " + event_end_tag
  end
  
  def ordinalize_event_datetime(event_datetime)
    event_datetime.strftime("%B #{event_datetime.day.ordinalize} at %l %p #{event_datetime.localtime.zone}")
  end

  def event_start(event)
    event.start_time.strftime("%B %d")
  end
  
  def event_end(event)
    event.end_time.strftime("%d, %Y")
  end
  
  def event_html_attrs(event_datetime)
     event_datetime.strftime("%Y-%m-%d")
  end
end
