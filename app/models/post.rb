class Post < ActiveRecord::Base
  validates :title, :presence => true, :length => { :minimum => 5}

  has_and_belongs_to_many :tags

  accepts_nested_attributes_for :tags

  def self.find_by_tag(tag)
  	Post.joins(:tags).where('tags.id' => tag.id).order(:created_at)
  end
end
