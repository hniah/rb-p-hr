class Feedback < ActiveRecord::Base
  extend Enumerize

  validates :kind, presence: true
  validates :content, presence: true

  belongs_to :staff

  enumerize :kind, in: [:feedback, :bug, :suggestion]
end

