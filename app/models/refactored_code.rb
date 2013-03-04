class RefactoredCode < ActiveRecord::Base
  attr_accessible :email, :refactored_code

  has_many :votes

  def vote_tally
    sum = 0
    votes.each do |vote|
      sum += vote.num
    end
    sum.to_f / votes.size
  end
end
