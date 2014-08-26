class Leave < ActiveRecord::Base
  extend Enumerize

  default_scope -> { order(id: :desc) }
  scope :approved, -> { where(status: :approved) }
  scope :rejected, -> { where(status: :rejected) }

  delegate :id, :english_name, :email, to: :staff, prefix: true, allow_nil: true
  delegate :id, :date, :kind, to: :leave_day, prefix: true, allow_nil: true

  has_many :leave_days, dependent: :delete_all
  accepts_nested_attributes_for :leave_days, :update_only => true, :allow_destroy => true
  belongs_to :staff

  validates :status, :reason, :staff, :category, presence: true
  validates :rejection_note, presence: {if: -> {status.present? && status.rejected?}}

  enumerize :status, in: [:pending, :approved, :rejected], default: :pending
  enumerize :category, in: [:unpaid, :sick, :annual, :compassionate, :maternity, :urgent], default: :annual



end
