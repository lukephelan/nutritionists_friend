class Intake < ActiveRecord::Base
  belongs_to :user

  validates :consumed_item, presence: true
  validates :consumed_uom, presence: true
  validates :consumed_qty, presence: true
  validates :logged_time, presence: true
  validates :logged_date, presence: true
end
