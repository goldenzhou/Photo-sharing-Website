class AddPasswordDigest < ActiveRecord::Migration
  def change
  	 add_column :users, :salt, :string
  	 add_column :users, :password_digest, :string
  	 User.reset_column_information
  	 User.all.each do |user|
  	    user.salt = Random.rand.to_s
  	    user.password_digest = Digest::SHA1.hexdigest(user.last_name.downcase + user.salt)
  	    user.save(:validate => false)
  	 end
  end
end
