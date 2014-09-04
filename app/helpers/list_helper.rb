module ListHelper

  def list_button(name:, action:, admin:, resource:)
    if action == :edit
      link_to name, [:edit, admin, resource], list_edit_button_options(resource)
    elsif action == :delete
      link_to name, [admin, resource], list_delete_button_options(resource)
    elsif action == :detail
      link_to name, [admin, resource], list_detail_button_options(resource)
    end
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

  def list_detail_button_options(resource)
    {method: :get, class: 'list-edit-button', data: {test: "view-#{resource_class(resource)}-#{resource.id}"}}
  end

  def bootstrap_paginate(resources)
    will_paginate(resources, {renderer: BootstrapPagination::Rails, next_label: '&raquo;', previous_label: '&laquo;'})
  end
end
