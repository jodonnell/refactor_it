class HomeController < ApplicationController
  def index
    
  end

  def login
    email = params[:email]
    session[:email] = email
    redirect_to show_original_code_path
  end

  def show_original_code
    bad_code
    bad_code_specs
  end

  def submit_refactored_code
    RefactoredCode.create :email => session[:email], :refactored_code => params[:refactored_code]
    redirect_to list_refactored_code_path
  end

  def list_refactored_code
    bad_code
    @refactored_codes = RefactoredCode.includes(:votes)
    @refactored_codes.sort! {|x, y| y.vote_tally <=> x.vote_tally }
  end

  def rate
    rc_id = params[:refactored_code_id]
    votes = Vote.where(email: session[:email]).where(refactored_code_id: rc_id)
    if votes.size == 0
      Vote.create(email: session[:email], refactored_code_id: rc_id, :num => params[:rate])
    end

    redirect_to list_refactored_code_path
  end

  def bad_code
    @bad_code = File.open("#{Rails.root}/app/models/query_string_parser.rb", 'r') { |f| f.read }
  end

  def bad_code_specs
    @bad_code_specs = File.open("#{Rails.root}/spec/models/query_string_parser_spec.rb", 'r') { |f| f.read }
    @bad_code_specs.gsub!('require "spec_helper"', '')
  end
end
