module Password
  include BCrypt

  def password=(value)
    self.encrypted_password = Password.create(value)
  end

  def password
    @password ||= Password.new(encrypted_password) if encrypted_password
  end
end