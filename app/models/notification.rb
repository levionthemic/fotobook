class Notification < ApplicationRecord
  belongs_to :user          # người nhận
  belongs_to :notifier, class_name: :user  # người gửi
  belongs_to :notifiable, polymorphic: true

  validates :action, presence: true
end
