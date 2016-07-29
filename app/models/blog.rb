class Blog < ActiveRecord::Base
  belongs_to :user
  mount_uploader :snapshot, SnapshotUploader
end
