# -*- coding: utf-8 -*-
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.dom_class = 'nav navbar-nav'

    primary.item :leaves, 'Leave', staff_leaves_path, if: -> { user_signed_in? && !current_user.is_admin? } do |submenu|
      submenu.item :index, 'Leaves List', staff_leaves_path
      submenu.item :new, 'Add New Leave', new_staff_leave_path
    end

    primary.item :leaves, 'Leave', admin_leaves_path, if: -> { user_signed_in? && current_user.is_admin? } do |submenu|
      submenu.item :index, 'Leaves List', admin_leaves_path
      submenu.item :new, 'Add New Leave', new_admin_leave_path
    end

    primary.item :users, 'Staff', admin_staffs_path, if: -> { user_signed_in? && current_user.is_admin? } do |submenu|
      submenu.item :index, 'Staff List', admin_staffs_path
      submenu.item :new, 'Add New Staff', new_admin_staff_path
    end

    primary.item :lates, 'Late', admin_lates_path, if: -> { user_signed_in? && current_user.is_admin? } do |submenu|
      submenu.item :index, 'Late List', admin_lates_path
      submenu.item :new, 'Add New Late', new_admin_late_path
    end

    primary.item :feedbacks, 'Feedback/Bug Report', new_feedback_path, if: -> { user_signed_in? } 
    primary.item :feedbacks, 'Feedbacks List', admin_feedbacks_path, if: -> { user_signed_in? && current_user.is_admin? }
  end
end
