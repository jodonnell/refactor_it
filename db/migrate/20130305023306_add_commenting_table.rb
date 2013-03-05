class AddCommentingTable < ActiveRecord::Migration
  def change
    create_table(:comments) do |t|
      t.string :email, :null => false, :default => ""
      t.integer :refactored_code_id, :null => false, :default => "0"
      t.string :comment
    end
  end
end
