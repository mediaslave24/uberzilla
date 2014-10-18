class Department < ActiveRecord::Base
  validate :name, uniqueness: true
  has_many :tickets
  has_many :staffs
end
