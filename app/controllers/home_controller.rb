class HomeController < ApplicationController
  def index
    
  end

  def login
    email = params[:email]
    session[:email] = email
    redirect_to show_original_code_path
  end

  def show_original_code
    
  end

  def submit_refactored_code
    RefactoredCode.create :email => session[:email], :refactored_code => params[:refactored_code]
    redirect_to list_refactored_code_path
  end

  def list_refactored_code
    @refactored_codes = RefactoredCode.order('votes desc')
  end

  def up_vote
    rc = RefactoredCode.find params[:refactored_code_id]
    rc.update_attribute(:votes, rc.votes + 1)
    redirect_to list_refactored_code_path
  end

  def down_vote
    rc = RefactoredCode.find params[:refactored_code_id]
    rc.update_attribute(:votes, rc.votes - 1)
    redirect_to list_refactored_code_path
  end
end
