class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  default_scope -> { order(name: :asc, id: :desc) }

  validates :name, :english_name, :personal_email, :address, :started_on, :probation_end_on, :designation, presence: true
  validates :email, format: { :with => /\A([^@\s]+)@(futureworkz.com)\Z/i }
  validates :personal_email, format:  { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  has_paper_trail class_name: 'Version', ignore: [:updated_at, :created_at]

  def self.find_for_google_oauth2(access_token)
    data = access_token.info
    User.where(email: (data['email']).downcase).first
  end

  def eql?(obj)
    obj.id == self.id && obj.is_a?(User)
  end

  private
  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end
end
