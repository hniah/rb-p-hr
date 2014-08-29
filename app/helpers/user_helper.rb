module UserHelper
  def staff_options(staffs)
    staffs.collect { |staff| [ staff.english_name, staff.id ] }
  end
end
