module VersionHelper
  def version_diff(version, resource)
    version.changeset.collect { |field, value|
      field_diff(field: field, old_value: value[0], new_value: value[1], event: version.event, resource: resource)
    }.join('<br>').html_safe
  end

  def field_diff(field: , new_value: , old_value: '', event:, resource:)
    translate_key = "#{resource_class(resource)}.events.#{event}"
    field_name = label_name("#{resource_class(resource)}.#{field}")

    t(translate_key,
      field: field_name,
      old_value: old_value,
      new_value: new_value
    )
  end
end
