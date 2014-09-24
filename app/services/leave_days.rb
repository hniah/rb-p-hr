class LeaveDays
  def self.add_leave_days_staff
    if LeaveDays.is_new_year?
      self.add_annual_leave_days
      self.add_cumulative_leave_days
    end
  end

  protected
  def self.is_new_year?
    Date.today.beginning_of_year == Date.today
  end

  private
  def self.leave_param(staff_id, total, sub_cate)
    { reason: 'Add Leave days for new year', status: :approved, staff_id: staff_id, category: :annual, start_day: Date.today.beginning_of_year, end_day: Date.today.end_of_year, total: total, sub_cate: sub_cate}
  end

  def self.staffs
    Staff.all
  end

  def self.add_annual_leave_days
    self.staffs.each do |staff|
      @leave = Leave.find_or_initialize_by(self.leave_param(staff.id, 14, 'carry-over leaves'))
      @leave.save
    end
  end

  def self.add_cumulative_leave_days
    self.staffs.each do |staff|
      cumulative_days = staff.remaining_leave_days(Time.now.year - 1)
      cumulative_days = 7 if cumulative_days > 7
      @leave = Leave.find_or_initialize_by(self.leave_param(staff.id, cumulative_days, 'cumulative leaves'))
      @leave.save
    end
  end

end
