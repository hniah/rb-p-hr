class LeaveDays
  def self.add_leave_days_staff
    self.staffs.each do |staff|
      @leave = Leave.find_or_initialize_by(self.leave_param(staff.id))
      @leave.save
    end
  end

  private
  def self.leave_param(staff_id)
    { reason: 'Add Leave days for new year', status: :approved, staff_id: staff_id, category: :annual, start_day: "01-01-#{Time.now.year} 08:30".to_date, end_day: "31-12-#{Time.now.year} 17:30".to_date, total: 14, sub_cate: 'carry-over leaves'}
  end

  def self.staffs
    Staff.all
  end
end
