module UserHelper
  def staff_options(staffs)
    staffs.collect { |staff| [ staff.english_name, staff.id ] }
  end

  def version_diff(version)
      version.changeset.collect { |field, value|
        field_diff(field: field, old_value: value[0], new_value: value[1], event: version.event)
      }.join('<br>').html_safe
  end

  def field_diff(field: , new_value: , old_value: '', event:)
    translate_key = "staff.events.#{event}"
    field_name = label_name("staff.#{field}")

    t(translate_key,
      field: field_name,
      old_value: old_value,
      new_value: new_value
    )
  end
end
