class Late < ActiveRecord::Base
  validates :staff, presence: true
  validates :staff_id, presence: true

  belongs_to :staff

  delegate :english_name, to: :staff, allow_nil: true, prefix: true
end
