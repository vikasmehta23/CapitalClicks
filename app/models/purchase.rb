class Purchase < ApplicationRecord
	belongs_to :user
	has_many :exports,dependent: :delete_all
	accepts_nested_attributes_for :exports, :allow_destroy => true
	has_attached_file :photo, styles: {
    medium: '300x300>',
    small: '140x140>',
    thumb: '64x64!'
  }
	validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
