class Staff < User
  has_many :tickets, as: :staff
  belongs_to :department
end
