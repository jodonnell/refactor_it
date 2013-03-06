class RefactoredCode < ActiveRecord::Base
  attr_accessible :email, :refactored_code, :anonymous, :language

  has_many :votes
  has_many :comments

  def vote_tally
    return 0 if votes.size == 0
    sum = 0
    votes.each do |vote|
      sum += vote.num
    end
    sum.to_f / votes.size
  end

  def anonymous?
    anonymous
  end
end
