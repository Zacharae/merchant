class Product < ActiveRecord::Base
  belongs_to :brand
  belongs_to :category
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  has_attached_file :avatar, 
  	:styles => { 
  		:medium => "400x400#", :thumb => "150x150>"}, 
  	 	:default_url => "missing_:style.png"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
	validates_attachment_size :avatar, :less_than => 5.megabytes

  validates :name, presence: true, length: {minimum: 2} 
  validates :brand, presence: true
  validates :category, presence: true

  def self.search_by_name_or_description(string)
    where("name LIKE ? OR description LIKE ?", "%#{string}", "%#{string}")
 end

 private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else 
      errors.add(:base, 'Line items present')
      return false
  end
end
end