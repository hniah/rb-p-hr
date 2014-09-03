module ListHelper
  def list_edit_button(resource, type)
    link_to 'Edit', list_action_path(resource, :edit, type), list_edit_button_options(resource)
  end

  def list_delete_button(resource, type)
    link_to 'Delete', list_action_path(resource, :delete, type), list_delete_button_options(resource)
  end

  def list_detail_button(resource, type)
    link_to 'Detail', list_action_path(resource, :detail, type), list_detail_button_options(resource)
  end

  def list_action_path(resource, action, type)
    if type == 'frontend'
      if action == :edit
        path = "edit_#{resource_class(resource)}_path".to_sym
      elsif action == :delete
        path = "#{resource_class(resource)}_path".to_sym
      elsif action == :detail
        path = "#{resource_class(resource)}_path".to_sym
      end
    elsif type == 'admin'
      if action == :edit
        path = "edit_admin_#{resource_class(resource)}_path".to_sym
      elsif action == :delete
        path = "admin_#{resource_class(resource)}_path".to_sym
      elsif action == :detail
        path = "admin_#{resource_class(resource)}_path".to_sym
      end
    end
    send(path, resource.id)
  end

  def resource_class(resource)
    resource.class.to_s.downcase
  end

  def list_detail_button_options(resource)
    {class: 'list-edit-button', data: {test: "view-#{resource_class(resource)}-#{resource.id}"}}
  end

  def list_edit_button_options(resource)
    {class: 'list-edit-button', data: {test: "edit-#{resource_class(resource)}-#{resource.id}"}}
  end

  def list_delete_button_options(resource)
    {method: :delete, class: 'list-delete-button', data:{confirm: t("#{resource_class(resource)}.message.delete_confirmation"), test: "delete-#{resource_class(resource)}-#{resource.id}"}}
  end

  def bootstrap_paginate(resources)
    will_paginate(resources, {renderer: BootstrapPagination::Rails, next_label: '&raquo;', previous_label: '&laquo;'})
  end
end
