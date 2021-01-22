class AddPostReferenceToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :posts, :users
  end
end
