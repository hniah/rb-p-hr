class Staff < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  default_scope -> { order(name: :asc, id: :desc) }

  validates :name, :english_name, :personal_email, :address, :phone_number, :basic_salary, :started_on, :probation_end_on, presence: true
  validates :email, format: { :with => /\A([^@\s]+)@(futureworkz.com)\Z/i }
  validates :personal_email, format:  { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  private
  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end
end
