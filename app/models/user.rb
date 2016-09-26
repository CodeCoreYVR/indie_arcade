class User < ApplicationRecord
  has_many :games, dependent: :nullify
  # has_secure_password
  #
  # mount_uploader :logo, LogoUploader
  # after_initialize :set_defaults
  #
  # VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  # validates :email, presence:   true,
  #                   uniqueness: { case_sensitive: false },
  #                   format:     VALID_EMAIL_REGEX
  #
  # validates :company, presence: true,
  #                     uniqueness: { case_sensitive: false }
  #
  # validates :password, presence: true,
  #                      length: { minimum: 6 }

  def full_name
    "#{first_name} #{last_name}".squeeze(" ").strip.titleize
  end

  def self.search(search)
    User.where("company ILIKE ?", "%#{search}%")
  end

  private

  def set_defaults
    self.admin ||= false
  end

end
