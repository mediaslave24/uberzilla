class User < ActiveRecord::Base
  belongs_to :department
  include Password
end
