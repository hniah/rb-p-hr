class Feedback < ActiveRecord::Base
  include Enumerize

  validates :type, presence: true
  validates :content, presence: true

  belongs_to :staff

  enumerize :type, in: [:feedback, :bug, :suggestion]
end

