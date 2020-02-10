class CreateCommentOfComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comment_of_comments do |t|
      t.text :content

      t.belongs_to :user, index: true
      t.belongs_to :comment, index: true
      t.timestamps
    end
  end
end
