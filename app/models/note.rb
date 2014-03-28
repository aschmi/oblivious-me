class Note < ActiveRecord::Base
  #before_save :parse_tags
  #acts_as_taggable
  belongs_to :user
  acts_as_taggable

  # has_many :taggings
  # has_many :tags, through: :taggings

  # accepts_nested_attributes_for :taggings

  # def self.tagged_with(names)
  #   Tag.find_by_name!(names).notes
  # end

  private
    def parse_tags
      self.tags = self.content.scan(/#\S+/).map do |tag|
        Tag.where(name: tag.strip).first_or_create!
      end
    end
end
