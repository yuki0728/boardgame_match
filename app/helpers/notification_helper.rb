module NotificationHelper
  # 通知メッセージをactionで分岐
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
    when "follow" then
      tag.a(visiter.username, href: user_path(visiter)) <<
      "さんがあなたをフォローしました。"
    end
  end

  # 通知未確認か？
  def notifications_unchecked?
    current_user.passive_notifications.where(checked: false).any?
  end
end
