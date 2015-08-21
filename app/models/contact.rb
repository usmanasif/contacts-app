class Contact < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :groups

  validates_presence_of :first_name, :last_name, :phone, :email
  validates_format_of :email, with: Devise::email_regexp

  validates :phone, phony_plausible: true
  phony_normalize :phone, default_country_code: 'US'

  mount_uploader :image, ImageUploader


  def name
    "#{first_name} #{last_name}".titleize
  end
end
