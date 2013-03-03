class Vote < ActiveRecord::Base
  attr_accessible :email, :refactored_code, :refactored_code_id, :num

  belongs_to :refactored_code
end
