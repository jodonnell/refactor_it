class AddRefactoredCode < ActiveRecord::Migration
  def change
    create_table(:refactored_codes) do |t|
      t.string :email, :null => false, :default => ""
      t.text :refactored_code
      t.integer :votes, :null => false, :default => "0"
    end
  end
end
