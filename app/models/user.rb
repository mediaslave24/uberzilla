class User < ActiveRecord::Base
  include Password
  validates :name, presence: true
  validates :email, email: true, uniqueness: true, presence: true
end
