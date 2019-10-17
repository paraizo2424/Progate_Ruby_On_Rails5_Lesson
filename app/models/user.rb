class User < ApplicationRecord
  has_secure_password
  validetes :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}

  def posts
    return Post.where(user_id: self.id)
  end
end
