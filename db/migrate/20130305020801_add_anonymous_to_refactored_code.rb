class AddAnonymousToRefactoredCode < ActiveRecord::Migration
  def change
    add_column :refactored_codes, :anonymous, :boolean
  end
end
