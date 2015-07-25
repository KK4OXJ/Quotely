class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
    	t.text :content

      add_user_id_to_quotes user_id:integer

      t.timestamps
    end
  end
end
