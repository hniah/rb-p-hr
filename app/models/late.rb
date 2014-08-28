class Late < ActiveRecord::Base
  validates :staff, :date, presence: true
  validates :staff_id, presence: true

  belongs_to :staff

  delegate :english_name, to: :staff, allow_nil: true, prefix: true

  after_initialize :assigns_default_values

  def assigns_default_values
    self.date ||= Date.today
  end
end
