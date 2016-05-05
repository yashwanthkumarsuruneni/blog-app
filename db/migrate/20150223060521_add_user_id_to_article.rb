class AddUserIdToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :user_id, :int
  end
end
