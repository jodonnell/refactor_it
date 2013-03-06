class HomeController < ApplicationController
  def index
    
  end

  def login
    email = params[:email]
    session[:email] = email
    redirect_to choose_language_path
  end

  def show_original_code
    @language = params[:language]
    if @language == 'ruby'
      bad_code
      bad_code_specs
    elsif @language == 'python'
      @bad_code = File.open("#{Rails.root}/code/query_string_parser.py", 'r') { |f| f.read }
      @bad_code_specs = File.open("#{Rails.root}/code/query_string_parser_test.py", 'r') { |f| f.read }
    end
  end

  def submit_refactored_code
    anonymous = params.key?(:anonymous) ? true : false
    RefactoredCode.create :email => session[:email], :refactored_code => params[:refactored_code], :anonymous => anonymous, :language => params[:language] unless params[:refactored_code].blank?
    redirect_to list_refactored_code_path(:language => params[:language])
  end

  def list_refactored_code
    @language = params[:language]
    bad_code
    @refactored_codes = RefactoredCode.includes(:votes).where(:language => @language)
    @refactored_codes.sort! {|x, y| y.vote_tally <=> x.vote_tally }
  end

  def comment
    rc_id = params[:refactored_code_id]
    Comment.create(email: session[:email], refactored_code_id: rc_id, :comment => params[:comment])
    redirect_to list_refactored_code_path(:language => params[:language])
  end

  def rate
    rc_id = params[:refactored_code_id]
    votes = Vote.where(email: session[:email]).where(refactored_code_id: rc_id)
    if votes.size == 0
      Vote.create(email: session[:email], refactored_code_id: rc_id, :num => params[:rate])
    end

    redirect_to list_refactored_code_path(:language => params[:language])
  end

  def bad_code
    @bad_code = File.open("#{Rails.root}/app/models/query_string_parser.rb", 'r') { |f| f.read }
  end

  def bad_code_specs
    @bad_code_specs = File.open("#{Rails.root}/spec/models/query_string_parser_spec.rb", 'r') { |f| f.read }
    @bad_code_specs.gsub!('require "spec_helper"', '')
  end
end
