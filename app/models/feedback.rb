class Feedback < ActiveRecord::Base
  extend Enumerize

  validates :kind, presence: true
  validates :content, presence: true

  delegate :english_name, to: :staff, prefix: true, allow_nil: true

  belongs_to :staff

  enumerize :kind, in: [:feedback, :bug, :suggestion]
end

