module EventHelpers
  def event_create_with(name, text, start_time, ending_time, participant_limit, tag_list, image)
    fill_in I18n.t(:"activerecord.attributes.event.name"), with: name
    fill_in I18n.t(:"activerecord.attributes.event.text"), with: text
    fill_in I18n.t(:"activerecord.attributes.event.start_time"), with: start_time
    fill_in I18n.t(:"activerecord.attributes.event.ending_time"), with: ending_time
    fill_in I18n.t(:"activerecord.attributes.event.participant_limit"), with: participant_limit
    fill_in I18n.t(:"activerecord.attributes.event.tag_list"), with: tag_list
    if image.nil?
      attach_file(I18n.t(:"activerecord.attributes.event.img"), File.join(Rails.root, image))
    end
    click_on I18n.t(:"helpers.submit.create")
  end
end
