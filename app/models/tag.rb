class Tag < ActiveRecord::Base
    belongs_to :photo
    belongs_to :user

    validates :left, :top, :width, :height, presence: true
end
