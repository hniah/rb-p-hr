class Late < ActiveRecord::Base

  default_scope -> { order(date: :desc) }

  validates :staff, :date, presence: true
  validates :staff_id, presence: true

  belongs_to :staff

  delegate :english_name, to: :staff, allow_nil: true, prefix: true

  has_paper_trail class_name: 'Version', ignore: [:updated_at, :created_at]

  after_initialize :assigns_default_values

  def assigns_default_values
    self.date ||= Date.today
  end
end
