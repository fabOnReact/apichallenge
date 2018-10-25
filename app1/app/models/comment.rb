class Comment < ApplicationRecord
  belongs_to :user
  scope :with_description, ->(text) { where("description like ?", text) }

  def self.find_comments(field)
    field.present? ? with_description(field) : all
  end 
end
