class Group < ActiveRecord::Base
  belongs_to :user

  has_many :contacts_groups
  has_and_belongs_to_many :contacts


  accepts_nested_attributes_for :contacts_groups, allow_destroy: true
end
