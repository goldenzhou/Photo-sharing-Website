class Comment < ActiveRecord::Base
	belongs_to  :user
	belongs_to  :photo

	def validate_comment
		if comment.empty?
			errors.add(:comment, "must not be empty!")
		end
	end

	validate :validate_comment
end
