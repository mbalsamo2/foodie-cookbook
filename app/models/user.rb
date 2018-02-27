class User < ActiveRecord::Base
  validates_presence_of :name, :password
  has_many :recipes
  has_secure_password

  def slug
    self.name.split(" ").map do |word|
      word.downcase
    end.join("-")
  end

  def self.find_by_slug(slug)
    unslug_name = slug.split("-").join(" ")
    User.where("LOWER(name) = ?", "#{unslug_name}").first
  end

  def reverse_recipe
    self.recipes.reverse
  end
end
