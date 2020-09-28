module SelectDateTimeHelpers
  def select_datetime(datetime, options = {})
    name = find('label', text: options[:from])[:for]

    select datetime.year.to_s,   from: "#{name}_1i"
    select datetime.month.to_s,  from: "#{name}_2i"
    select datetime.day.to_s,    from: "#{name}_3i"
    select datetime.hour.to_s,   from: "#{name}_4i"
    select datetime.minute.to_s, from: "#{name}_5i"
  end
end
