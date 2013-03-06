class AddLanguageToRefactoredCode < ActiveRecord::Migration
  def change
    add_column :refactored_codes, :language, :string
  end
end
