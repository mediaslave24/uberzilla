class Staff < User
  validates_presence_of :encrypted_password
  belongs_to :department
  delegate :name, to: :department, allow_nil: true, prefix: true
end
