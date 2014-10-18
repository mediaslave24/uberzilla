class User < ActiveRecord::Base
  include Password
  validates :name, presence: true
  validates :email, email: true, uniqueness: { scope: :name }, presence: true
  has_many :tickets, as: :customer
  has_many :assigned_tickets, as: :staff

  def as_json(*)
    super.merge type: type
  end
end
