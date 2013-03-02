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
  end
end
