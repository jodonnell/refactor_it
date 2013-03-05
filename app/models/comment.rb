class Comment < ActiveRecord::Base
  attr_accessible :email, :refactored_code, :refactored_code_id, :comment

  belongs_to :refactored_code
end
