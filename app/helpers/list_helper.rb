module ListHelper
  def list_edit_button(resource)
    link_to 'Edit', list_action_path(resource, :edit), list_edit_button_options(resource)
  end

  def list_delete_button(resource)
    link_to 'Delete', list_action_path(resource, :delete), list_delete_button_options(resource)
  end

  def bootstrap_paginate(resources)
    will_paginate(resources, {renderer: BootstrapPagination::Rails, next_label: '&raquo;', previous_label: '&laquo;'})
  end

  def list_action_path(resource, action)
    if action == :edit
      path = "edit_#{resource_class(resource)}_path".to_sym
    elsif action == :delete
      path = "#{resource_class(resource)}_path".to_sym
    end

    send(path, resource.id)
  end

  def resource_class(resource)
    resource.class.to_s.downcase
  end

  def list_edit_button_options(resource)
    {class: 'list-edit-button', data: {test: "edit-#{resource_class(resource)}-#{resource.id}"}}
  end

  def list_delete_button_options(resource)
    {method: :delete, class: 'list-delete-button', data:{confirm: t("#{resource_class(resource)}.message.delete_confirmation"), test: "delete-#{resource_class(resource)}-#{resource.id}"}}
  end
end
