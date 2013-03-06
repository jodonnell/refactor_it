class HomeController < ApplicationController
  before_filter :is_logged_in, :except => [:index, :login]

  def is_logged_in
    if session[:email].blank?
      redirect_to root_path
    end
  end

  def index
  end

  def login
    email = params[:email]
    session[:email] = email
    redirect_to choose_language_path
  end

  def choose_language
  end

  def show_original_code
    @language = params[:language]
    if @language == 'ruby'
      bad_code
      bad_code_specs
    elsif @language == 'python'
      @bad_code = File.open("#{Rails.root}/code/query_string_parser.py", 'r') { |f| f.read }
      @bad_code_specs = File.open("#{Rails.root}/code/query_string_parser_test.py", 'r') { |f| f.read }
    elsif @language == 'js'
      @spec_instructions = 'To run the specs you will need Jasmine which you can download here: https://github.com/pivotal/jasmine/downloads.  Unzip it, copy the code below into the spec directory in the unzipped jasmine folder, name it query_string_parser_spec.js.  In the src directory create query_string_parser.js, this is where your code will go.  Edit the SpecRunner.html file and change the includes under <!-- include source files here... --> and <!-- include spec files here... --> to point to the files you just created.  Now open this file in your browser to run the specs.'
      @bad_code = File.open("#{Rails.root}/code/js/src/query_string_parser.js", 'r') { |f| f.read }
      @bad_code_specs = File.open("#{Rails.root}/code/js/spec/query_string_parser_spec.js", 'r') { |f| f.read }
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
