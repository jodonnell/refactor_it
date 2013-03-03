class AddVotesTable < ActiveRecord::Migration
  def change
    remove_column :refactored_codes, :votes

    create_table(:votes) do |t|
      t.string :email, :null => false, :default => ""
      t.integer :refactored_code_id
      t.integer :num
    end
  end
end
