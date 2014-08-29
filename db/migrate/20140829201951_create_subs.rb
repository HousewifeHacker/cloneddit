class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :title, null: false, unique: true
      t.text :description
      t.references :moderator, index: true, null: false

      t.timestamps
    end
    
    add_index :subs, :title
  end
end
