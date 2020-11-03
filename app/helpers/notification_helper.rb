module NotificationHelper
  def notification_form(notification)
    visiter = notification.visiter
    event = notification.event

    case notification.action
    when "participation"
      tag.a(visiter.username, href: user_path(visiter)) <<
      "さんが「" <<
      tag.a(event.name, href: event_path(event)) <<
      "」に参加しました。"
    when "cancellation"
      tag.a(visiter.username, href: user_path(visiter)) <<
      "さんが「" <<
      tag.a(event.name, href: event_path(event)) <<
      "」の参加をキャンセルしました。"
    end
  end
end
