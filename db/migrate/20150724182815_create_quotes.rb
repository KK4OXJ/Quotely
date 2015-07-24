class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
    	t.text :content
      t.string :user_id
      t.references :user

      t.timestamps
    end
  end
end
