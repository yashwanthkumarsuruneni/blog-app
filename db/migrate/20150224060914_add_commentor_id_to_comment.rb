class AddCommentorIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :Commentor_Id, :int
  end
end
