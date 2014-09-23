class LeaveDays
  def self.add_leave_days_staff
    if LeaveDays.is_new_year?
      self.staffs.each do |staff|
        self.add_annual_leave_days(staff)
      end
    end
  end

  protected
  def self.is_new_year?
    Date.today.beginning_of_year == Date.today
  end

  private
  def self.leave_param(staff_id)
    { reason: 'Add Leave days for new year', status: :approved, staff_id: staff_id, category: :annual, start_day: Date.today.beginning_of_year, end_day: Date.today.end_of_year, total: 14, sub_cate: 'carry-over leaves'}
  end

  def self.staffs
    Staff.all
  end

  def self.add_annual_leave_days(staff)
    @leave = Leave.find_or_initialize_by(self.leave_param(staff.id))
    @leave.save
  end

end
