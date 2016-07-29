class AddSnapshotToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :snapshot, :string
  end
end
