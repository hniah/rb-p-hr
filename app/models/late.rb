class Late < ActiveRecord::Base
  validates :staff, presence: true

  belongs_to :staff
end
