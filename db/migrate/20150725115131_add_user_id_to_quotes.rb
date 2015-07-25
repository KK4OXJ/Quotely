class AddUserIdToQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.user_id :integer
      
      t.timestamps
    end
  end
end
