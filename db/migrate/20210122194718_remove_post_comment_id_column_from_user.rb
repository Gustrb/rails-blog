class RemovePostCommentIdColumnFromUser < ActiveRecord::Migration[5.1]
  def change

    remove_column :users, :comment_id
    add_reference :comments, :user
  end
end
