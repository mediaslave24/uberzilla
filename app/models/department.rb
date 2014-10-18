class Department < ActiveRecord::Base
  validate :name, uniqueness: true
end
