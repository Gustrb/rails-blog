class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title, limit: 100, null: false
      t.text :description

      t.timestamps
    end
  end
end
