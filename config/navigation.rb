# -*- coding: utf-8 -*-
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.dom_id = 'dashboard-menu'
    primary.selected_class = 'active'

    primary.item :home, fa_icon('home', text: '<span>Home</span>'.html_safe), root_path, if: -> { !current_user.is_admin? }

    primary.item :leaves, fa_icon('calendar', text: '<span>Leaves</span>'.html_safe), '#', class: 'has-submenu', if: -> { user_signed_in? && !current_user.is_admin? } do |submenu|
      submenu.dom_class = 'submenu'
      submenu.item :index, 'Leaves List', staff_leaves_path
      submenu.item :new, 'Submit a leave', new_staff_leave_path
    end

    primary.item :leaves, 'Leave', admin_leaves_path, if: -> { current_user.is_admin? } do |submenu|
      submenu.dom_class = 'sub-menu'
      submenu.item :index, 'Leaves List', admin_leaves_path
      submenu.item :new, 'Add New Leave', new_admin_leave_path
    end

    primary.item :users, 'Staff', admin_staffs_path, if: -> { user_signed_in? && current_user.is_admin? } do |submenu|
      submenu.dom_class = 'sub-menu'
      submenu.item :index, 'Staff List', admin_staffs_path
      submenu.item :new, 'Add New Staff', new_admin_staff_path
    end

    primary.item :lates, 'Late', admin_lates_path, if: -> { user_signed_in? && current_user.is_admin? } do |submenu|
      submenu.dom_class = 'sub-menu'
      submenu.item :index, 'Late List', admin_lates_path
      submenu.item :new, 'Add New Late', new_admin_late_path
    end

    primary.item :feedbacks, 'Feedbacks List', admin_feedbacks_path, if: -> { user_signed_in? && current_user.is_admin? }
    primary.item :settings, 'Setting', admin_settings_path, if: -> { user_signed_in? && current_user.is_admin? }
    primary.item :pcc, fa_icon('info', text: '<span>PCC</span>'.html_safe), pcc_path
  end
end
