class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.references :author, index: true, null: false
      t.references :post, index: true, null: false

      t.timestamps
    end
  end
end
