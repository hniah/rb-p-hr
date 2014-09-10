class Leave < ActiveRecord::Base
  extend Enumerize

  default_scope -> { order(id: :desc) }
  scope :approved, -> { where(status: :approved) }
  scope :rejected, -> { where(status: :rejected) }
  scope :pending, -> { where(status: :pending) }

  delegate :id, :english_name, :email, to: :staff, prefix: true, allow_nil: true

  belongs_to :staff

  validates :status, :reason, :staff, :category, presence: true
  validates :staff_id, presence: true
  validates :rejection_note, presence: {if: -> {status.present? && status.rejected?}}

  enumerize :status, in: [:pending, :approved, :rejected], default: :pending
  enumerize :category, in: [:unpaid, :sick, :annual, :compassionate, :maternity, :urgent], default: :annual

  has_paper_trail class_name: 'Version', ignore: [:updated_at, :created_at]

end
